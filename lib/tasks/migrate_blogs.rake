require 'nokogiri'
require 'base64'

namespace :spina_blog do
  desc 'migrates legacy refinery-blog posts, and their dragonfly-hosted images, to spina-blog'
  task migrate_posts: :environment do

    legacy_posts = Refinery::Blog::Post.with_globalize.all

    if legacy_posts.any?
        puts "Cleaning up existing Spina::Blog::Posts..."
        Spina::Blog::Post.destroy_all
    end

    blog_media_folder = Spina::MediaFolder.find_or_create_by!(name: 'blog')

    image_cache = {}
    image_skips = []
    images_migrated = 0

    # Extracts the source refinery_images.image_uid from a legacy inline `/system/images/<job>/<file>`
    # dragonfly URL (this app has no dragonfly gem - these are dead links - but the base64 job still
    # encodes the original image_uid, which is all we actually need).
    decode_dragonfly_uid = lambda do |src|
      match = src.match(%r{/system/images/([^/]+)/})
      return nil unless match

      # Some jobs are standard (not urlsafe) base64, with '+' percent-escaped as "%2B" in the
      # href - unescape first, then normalize to the standard alphabet before decoding.
      raw = URI.decode_www_form_component(match[1]).tr('-_', '+/')
      job = JSON.parse(Base64.decode64(raw))
      step = job.find { |s| s.is_a?(Array) && s[0] == 'f' }
      step && step[1]
    rescue ArgumentError, JSON::ParserError
      nil
    end

    # Attaches a legacy dragonfly file (by image_uid) to a new Spina::Image, caching per run so the
    # same physical file referenced by multiple posts/img tags is only uploaded once.
    attach_legacy_image = lambda do |image_uid|
      return image_cache[image_uid] if image_cache.key?(image_uid)

      legacy_image = Refinery::Image.find_by(image_uid: image_uid)
      if legacy_image.nil?
        image_skips << "image_uid=#{image_uid} (no refinery_images row)"
        next image_cache[image_uid] = nil
      end

      file_path = Rails.root.join('public', 'system', 'refinery', 'images', image_uid)
      unless File.exist?(file_path)
        image_skips << "image_uid=#{image_uid} (dragonfly file missing on disk)"
        next image_cache[image_uid] = nil
      end

      spina_image = Spina::Image.new(media_folder: blog_media_folder)
      saved = File.open(file_path, 'rb') do |f|
        spina_image.file.attach(io: f, filename: legacy_image.image_name.presence || File.basename(file_path))
        spina_image.save
      end

      unless saved
        image_skips << "image_uid=#{image_uid} (spina image save failed: #{spina_image.errors.full_messages.join(', ')})"
        next image_cache[image_uid] = nil
      end

      images_migrated += 1
      image_cache[image_uid] = spina_image
    end

    # Mirrors Spina's own Trix inline-image embedding (Spina::ImagesHelper#embedded_image_url),
    # just called via url_helpers directly since a rake task has no view/main_app context.
    embedded_url = lambda do |spina_image|
      resize_key = Spina.config.embedded_image_size.is_a?(Array) ? :resize_to_limit : :resize
      Rails.application.routes.url_helpers.rails_blob_path(
        spina_image.file.variant(resize_key => Spina.config.embedded_image_size), only_path: true
      )
    end

    # 2017-2018 posts were transferred raw from a different blogging system and carry inline
    # style="..." and legacy classes (kix-line-break, tr-caption, separator, etc.) that spill
    # past the .blog-body template container. Posts from 2019 onward are clean and untouched.
    sanitizer = Rails::Html::SafeListSanitizer.new
    allowed_tags = Rails::Html::SafeListSanitizer.allowed_tags + ['iframe']
    allowed_attrs = %w[href src alt title width height target frameborder allowfullscreen]
    youtube_hosts = %w[youtube.com www.youtube.com youtube-nocookie.com www.youtube-nocookie.com]

    # The sanitizer's tag allowlist can't express a per-domain rule, so strip any iframe that
    # isn't a YouTube embed (e.g. the dead blogger.com/video.g link) before sanitizing.
    strip_non_youtube_iframes = lambda do |doc|
      doc.css('iframe').each do |iframe|
        host = URI.parse(iframe['src'].to_s).host rescue nil
        iframe.remove unless youtube_hosts.include?(host)
      end
    end

    legacy_posts.each do |oldpost|
        puts "Migrating: #{oldpost.title}"

        # Fix Author ID Assignment
        post_author_id = oldpost.user_id
        post_author_id = 44 if post_author_id == 9

        # Process HTML: Convert <p> to <div> for Spina/Trix compatibility
        body_html = oldpost.body
        if body_html.present?
          doc = Nokogiri::HTML::DocumentFragment.parse(body_html)
          doc.css('p').each { |p| p.name = 'div' }

          # Only dragonfly-hosted inline images get migrated - external src's (blogspot/twimg/etc,
          # leftovers from an old Blogger import) are left byte-for-byte untouched.
          doc.css('img[src*="/system/images/"]').each do |img|
            image_uid = decode_dragonfly_uid.call(img['src'])
            unless image_uid
              image_skips << "post id=#{oldpost.id} (couldn't decode dragonfly job from #{img['src']})"
              next
            end

            spina_image = attach_legacy_image.call(image_uid)
            img['src'] = embedded_url.call(spina_image) if spina_image
          end

          legacy_import = ((oldpost.published_at || oldpost.created_at)&.year.to_i) <= 2018
          if legacy_import
            strip_non_youtube_iframes.call(doc)
            sanitized = sanitizer.sanitize(doc.to_html, tags: allowed_tags, attributes: allowed_attrs)

            doc = Nokogiri::HTML::DocumentFragment.parse(sanitized)
            doc.css('img').each { |img| img['class'] = 'img-responsive' }
          end

          body_html = doc.to_html
        end

        featured_legacy_image = Refinery::Image.find_by(id: oldpost.image_id) if oldpost.image_id.present?
        spina_featured_image = attach_legacy_image.call(featured_legacy_image.image_uid) if featured_legacy_image

        new_post = Spina::Blog::Post.new(
            id: oldpost.id,
            title: oldpost.title,
            excerpt: oldpost.custom_teaser,
            content: body_html, # Now using the converted DIV content
            draft: oldpost.draft,
            published_at: oldpost.published_at,
            slug: oldpost.translated_slug,
            created_at: oldpost.created_at,
            updated_at: oldpost.updated_at,
            user_id: post_author_id,
            category: Spina::Blog::Category.first,
            tags: oldpost.tags,
            image: spina_featured_image
        )

      if new_post.save
        puts "Success (ID: #{new_post.id})"
      else
        puts "Failed! Errors: #{new_post.errors.full_messages.join(', ')}"
        # byebug # Uncomment if you need to debug failures
      end
    end

    puts "Migrated #{images_migrated} image(s) from dragonfly to ActiveStorage."
    puts "Image skips (#{image_skips.size}): #{image_skips.join('; ')}" if image_skips.any?
    puts 'All done!'
  end
end
