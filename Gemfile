source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.4.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.0'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Spree-commerce
gem 'spree', '~> 3.6.1'
gem 'spree_auth_devise', '~> 3.3'
gem 'spree_gateway', '~> 3.3'

# Spree extensions
# social_network
gem 'twitter', '5.8.0'
gem 'koala', '1.9.0' # For Facebook https://github.com/arsduo/koala
gem 'instagram', '1.1.6'



# custom spree extensions
# # - external
gem 'spree_paypal_express', github: 'spree-contrib/better_spree_paypal_express' # '3.3.0'
# -- start spree_static_content for Spree >= 3.1 (we need them all because of broken dependency on globalize)
gem 'globalize', github: 'globalize/globalize'
gem 'spree_i18n', github: 'spree-contrib/spree_i18n'
gem 'spree_globalize', github: 'spree-contrib/spree_globalize', branch: 'master'
gem 'spree_static_content', github: 'spree-contrib/spree_static_content'
# -- end spree_static_content

# start local/internal
gem 'testimonials_engine', require: 'testimonials_engine', path: 'extensions/testimonials_engine'
gem 'features_engine', require: 'features_engine', path: 'extensions/features_engine' # https://github.com/DynamoMTL/spree_features
gem 'affiliate_engine', require: 'affiliate_engine', path: 'extensions/affiliate_engine' # https://github.com/spree-contrib/spree_affiliate
gem 'watermark_engine', require: 'watermark_engine', path: 'extensions/watermark_engine' # https://github.com/azimuth/spree_watermark

# gem 'spree_last_address', require: 'spree_last_address', path: 'extensions/spree_last_address' # git://github.com/TylerRick/spree_last_address.git
gem 'spree_sales_prices_engine', require: 'spree_sales_prices_engine', path: 'extensions/spree_sales_prices_engine'

gem 'dynamic_content_management_engine', require: 'dynamic_content_management_engine', path: 'extensions/dynamic_content_management_engine'
gem 'tinymce-rails', '~> 4.1.10' # 3.5.11, 4.1.10 and 4.2.1 support sprockets 3
gem 'truncate_html', '0.9.3'
# end local/internal

# # we will use third party services such as Wordpress and Flick
gem 'news_engine', require: 'news_engine', path: 'extensions/news_engine' # used in about > faq
# gem "galleries_engine", require: "galleries_engine", path: "extensions/galleries_engine"
