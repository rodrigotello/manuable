# encoding: utf-8
require 'carrierwave/processing/mime_types'
class AvatarUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper
  include CarrierWave::MimeTypes
  process :set_content_type

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage Rails.env.production? ? :fog : :file

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process :crop
    process resize_to_fill: [50, 50]
  end

  version :small do
    process resize_to_limit: [100, 100]
  end

  version :medium do
    process resize_to_limit: [200, 200]
  end

  version :large do
    process resize_to_limit: [300, 300]
  end

  def default_url
    size = AvatarUploader.versions[version_name||:medium][:uploader].processors[0][1][0]
    "http://avatar.3sd.me/#{size}"
  end

  def crop
    if model.crop_x.present?
      resize_to_limit(300, 300)
      manipulate! do |img|
        x = model.crop_x.to_i
        y = model.crop_y.to_i
        w = model.crop_w.to_i
        h = model.crop_h.to_i
        img.crop!(x, y, w, h)
      end
    end
  end
  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
