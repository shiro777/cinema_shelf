source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'
gem 'bcrypt'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'bootstrap-sass'
gem 'coffee-rails', '~> 4.2'
gem 'dotenv-rails'
gem 'jbuilder', '~> 2.5'
gem 'mysql2'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.3'
gem 'rails-i18n'
gem 'sass-rails', '~> 5.0'
gem 'slim-rails', '~> 3.2.0'
gem 'sqlite3'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 4.10.0'
  gem 'rspec-rails', '~> 3.9.0'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'chromedriver-helper'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers',
      git: 'https://github.com/thoughtbot/shoulda-matchers.git',
      branch: 'rails-5'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
