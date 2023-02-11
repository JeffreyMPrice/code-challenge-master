# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.7'

# Rails
gem 'rails', '5.2.4.3'

# Drivers
gem 'sequel'
gem 'sqlite3', '~> 1.4'

# App Server
gem 'puma'
gem 'rack-cors'

# Assets
gem 'jbuilder'

# Security
gem 'bcrypt'

# Others
gem 'awesome_print'
gem 'date_validator' # makes it easier to validate times/dates
gem 'email_validator' # makes it easier to validate email
gem 'tzinfo-data', '>= 1.2016.7' # better timezone data

# Only for Development
group :development, :test do
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-byebug'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'timecop'
end
