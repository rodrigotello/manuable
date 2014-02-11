if RUBY_VERSION =~ /1.9/ # assuming you're running Ruby ~1.9
  Encoding.default_external = Encoding::UTF_8
  Encoding.default_internal = Encoding::UTF_8
end
source 'https://rubygems.org'
gem 'rails', '~> 4.0'
gem 'commontator', '~> 4.2.0'
gem "manuable-entities", :path => "vendor/gems/manuable-entities"
gem "draper"
gem "httpclient"
gem "sprockets-rails"
gem "pg"
gem 'conekta'
gem "roadie", "~> 2.4.3"
# DB
  group :production do
    gem 'puma', :github => 'puma/puma'
    gem 'newrelic_rpm'
  end
  gem 'activemerchant'
  gem "jquery-rails"
  gem "jquery-ui-rails"
# attachments
  gem 'carrierwave'
  gem "fog", "~> 1.3.1"
  gem 'rmagick'

# pagination
  gem 'kaminari'

# social login
  gem "omniauth"
  gem "omniauth-facebook"
  gem "omniauth-github"
  gem "omniauth-google-oauth2"
  gem "omniauth-oauth"
  gem "omniauth-oauth2"
  gem "omniauth-twitter"


# authorization & authentication
  gem "devise"
  gem "cancan"

# dev tools
  gem "haml"
  gem "haml-rails"
  gem "twitter-bootstrap-rails"
  gem "less-rails"
  gem "libv8", "~> 3.11.8"
  gem "therubyracer", :require => false
  gem 'simple_form'
  gem 'nested_form'
  # gem 'client_side_validations'
  # gem 'client_side_validations-simple_form'
  gem 'yaml_db'
  gem "squeel"
  gem 'quiet_assets'

gem 'acts-as-taggable-on'
gem 'daemons'
# gem "activeadmin"
# gem "meta_search", ">= 1.1.0.pre"
gem "ransack"
gem "jquery-fileupload-rails"

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

group :development do

  gem 'guard-livereload'
  gem 'rack-livereload'
  gem "better_errors"
  gem "binding_of_caller"
  gem 'meta_request'
  gem 'letter_opener'
  gem 'rails-footnotes', '>= 3.7.9'
end

group :development, :test do
  gem "guard", :require => false
  gem "guard-rspec", :require => false
  gem "guard-spork", :require => false
  gem "pry"
  gem "pry-rails"
  gem "pry-nav"
  gem "debugger"
  gem 'thin'
end

group :test do
  gem "factory_girl_rails"
  gem "rspec-rails"
  gem "database_cleaner"
  gem 'capybara-screenshot'
  gem "poltergeist"
  gem "database_cleaner"
end
