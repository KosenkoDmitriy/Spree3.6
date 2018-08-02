require 'spree_core'

module TestimonialsEngine
  class Engine < Rails::Engine

  	engine_name "testimonials_engine"
    isolate_namespace TestimonialsEngine

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
