source 'https://rubygems.org'

gem 'rails'
# DB
  gem 'sqlite3'
  gem "pg"

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
  gem 'jquery-rails'
  gem 'unicorn'
  gem "haml"
  gem "haml-rails"
  gem "twitter-bootstrap-rails"
  gem "less-rails"
  gem 'simple_form'
  gem 'nested_form'
  gem 'client_side_validations'
  gem 'client_side_validations-simple_form'

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

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem 'meta_request'
end

group :development, :test do
  gem "yard", :require => false
  gem "simplecov", :require => false
  gem "simplecov-rcov", :require => false
  gem "rails3-generators"
  gem "guard", :require => false
  gem "guard-rspec", :require => false
  gem "guard-spork", :require => false
  gem "growl", :require => false
  gem "pry"
  gem "pry-nav"
  gem "debugger"
end

group :test do
  gem "sqlite3"
  gem "rspec-rails"
  gem "database_cleaner"
  gem "factory_girl_rails"
end
