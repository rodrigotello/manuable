# encoding: utf-8
require 'carrierwave/processing/mime_types'
require 'carrierwave/storage/fog'

class AttachUploader < CarrierWave::Uploader::Base

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
    "uploads/#{model.class.to_s.underscore}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [140, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :thumb, if: :image? do
    process resize_to_limit: [50, 50]
  end

  version :small, if: :image? do
    process resize_to_limit: [100, 100]
  end

  version :medium, if: :image? do
    process resize_to_limit: [140, 140]
  end

  version :large, if: :image? do
    process resize_to_limit: [300, 300]
  end

  version :xlarge, if: :image? do
    process resize_to_limit: [500, 500]
  end

  version :xxlarge, if: :image? do
    process resize_to_limit: [1200, 1200]
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

  def default_url
    size = AttachUploader.versions[version_name||:medium][:uploader].processors[0][1].join("x")
    # "holder.js/#{size}/industrial"
    ""
  end

  protected
    def image?(new_file)
      return false unless new_file && new_file.content_type
      new_file.content_type.include? 'image'
    end
end
