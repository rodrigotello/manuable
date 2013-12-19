if RUBY_VERSION =~ /1.9/ # assuming you're running Ruby ~1.9
  Encoding.default_external = Encoding::UTF_8
  Encoding.default_internal = Encoding::UTF_8
end
source 'https://rubygems.org'
gem 'rails', "~>3.2"

gem "manuable-entities", :path => "vendor/gems/manuable-entities"
gem "draper"
gem "httpclient"

gem "pg"

# DB
  group :production do
    gem 'puma', :github => 'puma/puma'
    gem 'newrelic_rpm'
  end
  gem 'activemerchant'
  gem "jquery-rails", "2.3.0"
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
  gem 'simple_form'
  gem 'nested_form'
  gem 'client_side_validations'
  gem 'client_side_validations-simple_form'
  gem 'yaml_db'
  gem "squeel"
  gem 'quiet_assets'

gem 'acts-as-taggable-on'
gem 'daemons'
gem "activeadmin"
gem "meta_search", ">= 1.1.0.pre"
gem "capistrano", :require => false
gem "capistrano-ext", :require => false
gem "capistrano-helpers", :require => false
gem "capistrano_colors", :require => false
gem "rvm-capistrano", :require => false
gem "libv8", "~> 3.11.8"
gem "therubyracer", :require => false
gem "foreman", :require => false
gem "jquery-fileupload-rails"

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
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
  gem "yard", :require => false
  gem "simplecov", :require => false
  gem "simplecov-rcov", :require => false
  gem "rails3-generators"
  gem "guard", :require => false
  gem "guard-rspec", :require => false
  gem "guard-spork", :require => false
  gem "capybara"
  gem "growl", :require => false
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
