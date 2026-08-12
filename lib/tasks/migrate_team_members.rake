namespace :spina_team_members do
  desc 'migrates legacy refinery team members and their dragonfly photos to Spina::TeamMember/Spina::Image'
  task migrate: :environment do
    imported = 0
    photos_migrated = 0
    skipped = []
    photo_skips = []

    Refinery::TeamMembers::TeamMember.order(:position).each do |legacy|
      member = Spina::TeamMember.find_by(id: legacy.id)

      if member
        # Idempotency: ids are preserved 1:1 from refinery_team_members so that the existing
        # conference_team_members.team_member_id values (real data, already pointing at these
        # ids) keep resolving correctly without a separate data-fix pass.
        skipped << "id=#{legacy.id} (already imported)"
      else
        if legacy.firstname.blank?
          skipped << "id=#{legacy.id} (no firstname)"
          next
        end

        member = Spina::TeamMember.new(
          id: legacy.id,
          firstname: legacy.firstname,
          middlename: legacy.middlename,
          lastname: legacy.lastname,
          role: legacy.role,
          description: legacy.description,
          twitter: legacy.twitter,
          linkedin: legacy.linkedin,
          position: legacy.position,
          show_on_homepage: legacy.show_on_homepage
        )

        unless member.save
          skipped << "id=#{legacy.id} (#{member.errors.full_messages.join(', ')})"
          next
        end

        imported += 1
      end

      # Photo backfill - runs for both newly-imported and already-imported members, so
      # re-running this task (e.g. once the dragonfly files are actually present, which they
      # aren't in a plain prod-DB-snapshot dev environment - only the refinery_images *rows*
      # come with the dump, not the files on disk) picks up photos it couldn't migrate before.
      next if member.photo.present?
      next if legacy.photo_id.blank?

      legacy_image = Refinery::Image.find_by(id: legacy.photo_id)
      if legacy_image.nil?
        photo_skips << "id=#{legacy.id} (no refinery_images row for photo_id=#{legacy.photo_id})"
        next
      end

      # Dragonfly's filesystem datastore for refinerycms-images: image_uid is the path
      # relative to this root.
      file_path = Rails.root.join('public', 'system', 'refinery', 'images', legacy_image.image_uid.to_s)
      unless File.exist?(file_path)
        photo_skips << "id=#{legacy.id} (dragonfly file missing on disk: #{legacy_image.image_uid})"
        next
      end

      spina_image = Spina::Image.new
      saved = File.open(file_path, 'rb') do |f|
        spina_image.file.attach(
          io: f,
          filename: legacy_image.image_name.presence || File.basename(file_path)
        )
        spina_image.save
      end

      if saved
        member.update!(photo: spina_image)
        photos_migrated += 1
      else
        photo_skips << "id=#{legacy.id} (spina image save failed: #{spina_image.errors.full_messages.join(', ')})"
      end
    end

    # ids were assigned explicitly above, so the bigserial sequence needs to catch up or the
    # next admin-created team member would collide with an imported id.
    ActiveRecord::Base.connection.reset_pk_sequence!('spina_team_members') if imported > 0

    # The FK added in the repoint migration is validate: false (spina_team_members was still
    # empty at migration time) - validate it here now that the data actually lines up. Safe to
    # re-run; VALIDATE CONSTRAINT is a no-op once already valid.
    ActiveRecord::Base.connection.validate_foreign_key(
      :conference_team_members, :spina_team_members, column: :team_member_id
    )

    # Ensure the sitewide /about custom page exists (Spina::Account#bootstrap_website only
    # fires on Account#save - this is exactly how the "homepage" custom page is materialized
    # today too), so /about is live immediately after this task runs.
    Spina::Account.first&.save

    puts "Imported #{imported} team member(s)."
    puts "Migrated #{photos_migrated} photo(s) from dragonfly to ActiveStorage."
    puts "Skipped #{skipped.size} member(s): #{skipped.join('; ')}" if skipped.any?
    puts "Photo skips (#{photo_skips.size}): #{photo_skips.join('; ')}" if photo_skips.any?
    puts 'NOTE: Team members with no migrated photo need one uploaded by hand via /cms (e.g. any dragonfly file missing from this environment).'
  end
end
