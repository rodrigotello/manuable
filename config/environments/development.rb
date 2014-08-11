Manuable::Application.configure do
  config.middleware.use Rack::LiveReload
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  config.action_mailer.delivery_method = :letter_opener
  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  #config.action_mailer.default_url_options = { :host => "localhost", :port => '3000' }

  # Specifies the header that your server uses for sending files
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  #config.action_mailer.default_url_options = { :host => "www.manuable.com" }
  config.action_mailer.default_url_options = { :host => "localhost", :port => '3000' }
  config.action_mailer.smtp_settings = {
    :address   => "smtp.mailgun.org",
    :port      => 587,
    #:enable_starttls_auto => true, # detects and uses STARTTLS
    :user_name => "postmaster@sandbox6a61ab7f86b243d381f88141d7baf32d.mailgun.org",
    :password  => "d081135b9816dfd51c9c13d45737c019", # SMTP password is any valid API key
    :authentication => 'plain', # Mandrill supports 'plain' or 'login'
    :domain => 'manuable.com', # your domain to identify your server when connecting
  }

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true
  # Footnotes::Filter.prefix = 'mvim://open?url=file://%s&line=%d&column=%d'
  config.eager_load = false
  Conekta.api_key = 'key_5W9AbycDhrdyyC66'
end

