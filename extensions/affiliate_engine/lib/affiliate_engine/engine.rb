require 'geocoder'
require 'gmaps4rails'
require 'paperclip'
require 'fog'
require 'ransack'

module AffiliateEngine
  class Engine < ::Rails::Engine
    isolate_namespace AffiliateEngine
  end
end
