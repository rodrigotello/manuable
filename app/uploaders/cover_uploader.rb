# encoding: utf-8
require 'carrierwave/processing/mime_types'
class CoverUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  include Sprockets::Rails::Helper
  # include Sprockets::Helpers::IsolatedHelper
  include CarrierWave::MimeTypes
  process :set_content_type

  # Choose what kind of storage to use for this uploader:
  # storage :file
  #storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :cover do
    process resize_to_fill: [1064, 396]
  end

  def default_url
    "/assets/#{model.class.to_s.parameterize}-cover-dummy.png"
  end

end
