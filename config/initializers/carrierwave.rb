CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => ENV['AWS_ACCESS_KEY'],                        # required
    :aws_secret_access_key  => ENV['AWS_SECRET_KEY']
  }
  config.cache_dir = "#{Rails.root}/tmp/uploads"
  config.fog_directory  = 'manuable02'                     # required
  config.fog_public     = false                                   # optional, defaults to true
  config.fog_attributes = { 'Cache-Control' => 'max-age=315576000' }  # optional, defaults to {}
  # config.asset_host       = "//manuable.s3.amazonaws.com/"

  if Rails.env.test? or Rails.env.cucumber?
    config.storage = :file
    config.enable_processing = false
  end
end
