CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    #:aws_access_key_id      => ENV['AWS_ACCESS_KEY'],                        # required
    #:aws_secret_access_key  => ENV['AWS_SECRET_KEY'],
    :aws_access_key_id      => 'AKIAJRMTLFJYA6JZYGHA',
    :aws_secret_access_key  => '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',
    :region                 => 'us-west-2'
  }
  config.cache_dir = "#{Rails.root}/tmp/uploads"
  config.fog_directory  = 'manuable02'                     # required
  config.fog_public     = false                                   # optional, defaults to true
  #config.asset_host     = "https://manuable02.s3-us-west-2.amazonaws.com/"
  config.fog_attributes = { 'Cache-Control' => 'max-age=315576000' }  # optional, defaults to {}

  config.storage = :fog
  config.enable_processing = false

end
