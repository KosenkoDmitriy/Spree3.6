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
# gem 'spree_features', github: 'DynamoMTL/spree_features' # for spree > 2.3
# gem 'spree_affiliate', github: 'spree-contrib/spree_affiliate', branch: '2-2-stable'
# gem 'spree_watermark'      # https://github.com/azimuth/spree_watermark
# gem 'better_spree_paypal_express', github: 'spree-contrib/better_spree_paypal_express', branch: '3-0-stable'
# gem 'spree_last_address'    # https://github.com/TylerRick/spree_last_address
# gem 'spree_sales', github: 'ronzalo/spree_sales', branch: '3-1-stable' # https://github.com/ronzalo/spree_sales
# # -- start spree_static_content for Spree >= 3.1 (we need them all because of broken dependency on globalize)
# gem 'globalize', github: 'globalize/globalize'
# gem 'spree_i18n', github: 'spree-contrib/spree_i18n'
# gem 'spree_globalize', github: 'spree-contrib/spree_globalize', branch: 'master'
# gem 'spree_static_content', github: 'spree-contrib/spree_static_content'
# # -- end spree_static_content
# # - end external

# start local/internal
# TODO fix undefined local variable or method `testimonials_engine' in admin panel
# gem "testimonials_engine", :require => "testimonials_engine", :path => "extensions/testimonials_engine"

# TODO: resolve dependency for features_engine gem
# gem "features_engine", :require => "features_engine", :path => "extensions/features_engine" # https://github.com/DynamoMTL/spree_features
# TODO: resolve dependency for affiliate_engine gem
# gem "affiliate_engine", :require => "affiliate_engine", :path => "extensions/affiliate_engine" # https://github.com/spree-contrib/spree_affiliate
# TODO: will fix a NameError: uninitialized constant Photo
# gem 'watermark_engine', :require => "watermark_engine", :path => "extensions/watermark_engine" # https://github.com/azimuth/spree_watermark

# TODO will change to better_spree_paypal_express gem
# gem "spree_paypal_express", :require => "spree_paypal_express", :path => "extensions/spree_paypal_express" # https://github.com/spree/spree_paypal_express
#gem 'spree_paypal_express', :git => 'git://github.com/spree/spree_paypal_express.git', :branch => "1-3-stable" # latest 2-0-stable

# TODO: resolve dependency for spree_last_address gem
# gem 'spree_last_address', :require => "spree_last_address", :path => "extensions/spree-last-address"
# gem 'spree_last_address', :require => "spree_last_address", :path => "extensions/spree_last_address" # git://github.com/TylerRick/spree_last_address.git

# TODO: will fix `method_missing': undefined method `attr_accessible'
# gem "sales_prices_engine", :require => "sales_prices_engine", :path => "extensions/sales_prices_engine"

# TODO: resolve dependency for spree_static_content gem
# gem 'spree_static_content', github: 'spree/spree_static_content', branch: '2-0-stable'
# gem 'spree_static_content', github: 'spree-contrib/spree_static_content'#, branch: '3-0-stable' # for spree 3.0 and 2.x only
# -- start spree_static_content for Spree >= 3.1 (we need them all because of broken dependency on globalize)
gem 'globalize', github: 'globalize/globalize'
gem 'spree_i18n', github: 'spree-contrib/spree_i18n'
gem 'spree_globalize', github: 'spree-contrib/spree_globalize', branch: 'master'
gem 'spree_static_content', github: 'spree-contrib/spree_static_content'
# -- end spree_static_content
# TODO will fix in admin panel: undefined local variable or method `dynamic_content_management_engine'
gem "dynamic_content_management_engine", :require => "dynamic_content_management_engine", :path => "extensions/dynamic_content_management_engine"
# end local/internal

# # we will use third party services such as Wordpress and Flick
# gem "news_engine", :require => "news_engine", :path => "extensions/news_engine"
# gem "galleries_engine", :require => "galleries_engine", :path => "extensions/galleries_engine"
