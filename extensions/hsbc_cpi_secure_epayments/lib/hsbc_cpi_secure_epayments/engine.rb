module HsbcCpiSecureEpayments
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'hsbc_cpi_secure_epayments'

    config.autoload_paths += %W(#{config.root}/lib)

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end

      #PaymentMethod::HsbcCpiSecureEpayment.register
    end

    initializer "spree.register.payment_methods" do |app|
      #app.config.spree.payment_methods = [Spree::PaymentMethod::Check]
      app.config.spree.payment_methods << Spree::PaymentMethod::HsbcCpiSecureEpayment
    end

    config.to_prepare &method(:activate).to_proc
  end
end