# encoding: utf-8

class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include CarrierWave::Compatibility::Paperclip
  include CarrierWave::BombShelter

  # use cloudinary if it's configured
  if Cloudinary.config.cloud_name
    # use https by default
    Cloudinary.config.secure = true

    include Cloudinary::CarrierWave

    def public_id
      model.try(:photo_file_name) || model.try(:logo_file_name)
    end
  end

  after :store, :try_deinterlace

  def try_deinterlace(file)
    manipulate! do |img|
      img.interlace('none')
    end
  end

  def paperclip_path
    "system/#{object_class_name}/#{extra_store_dir}/#{id_partition}/:style/:basename.:extension"
  end

  def object_class_name
    model.class.to_s.underscore.pluralize
  end

  # compatibility with our paperclip storage paths..
  def extra_store_dir
    case object_class_name
    when 'conferences'
      'logos'
    when 'lodgings'
      'photos'
    when 'activities'
      'photos'
    when 'sponsors'
      'logos'
    when 'venues'
      'photos'
    else mounted_as
    end
  end

  # Returns the id of the instance in a split path form. e.g. returns
  # 000/001/234 for an id of 1234. Stolen from paperclip...
  def id_partition
    ('%09d'.freeze % model.id).scan(/\d{3}/).join('/'.freeze)
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "system/#{object_class_name}/#{mounted_as}/#{model.id}"
  end

  def image
    @image ||= MiniMagick::Image.open(file.file)
  end

  # Create different versions of your uploaded files:
  version :large do
    process resize_to_fit: [300, 300]
  end

  version :medium do
    process resize_to_fit: [130, 130]
  end
    
  version :thumb, from_version: :large do
    process resize_to_fit: [100, 100]
  end

  version :first, if: :sponsor?
  version :first do
    process resize_and_pad: [320, 200, 'white']
  end

  version :second, if: :sponsor?
  version :second, from_version: :first do
    process resize_and_pad: [320, 160, 'white']
  end

  version :others, if: :sponsor?
  version :others, from_version: :second do
    process resize_and_pad: [320, 140, 'white']
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def content_type_whitelist
    %r{/image\//}
  end

  private

  def sponsor?(_picture)
    object_class_name == 'sponsors'
  end
end
