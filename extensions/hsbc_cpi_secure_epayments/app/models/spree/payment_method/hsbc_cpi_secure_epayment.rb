# encoding: utf-8
class Spree::PaymentMethod::HsbcCpiSecureEpayment < Spree::PaymentMethod

  preference :hsbc_cpi_secure_secret, :string
  preference :storefront_id, :string
  preference :transaction_mode, :string # T or P
  preference :force_production_gateway, :boolean # Used to force the use of the production URL (to bypass staging site)

  attr_accessible :preferred_hsbc_cpi_secure_secret, :preferred_storefront_id, :preferred_transaction_mode, :preferred_force_production_gateway

  def payment_source_class
    ::Spree::HsbcCpiTransaction
  end

  # Required for Auth/Capture/Void actions to have access to the HSBC source
  def payment_profiles_supported?
    true
  end

  # provided for spree order payment completion
  # This is called after we've actually received the postback from HSBC
  # So all we need to do is return a Repsonse that the payment class can call
  def authorize payment, source, gateway_options
    Response.new source
  end

  def capture payment, source, gateway_options
    Response.new source
  end
  
  def void payment, source, gateway_options
    Response.new source
  end

  class Response

    attr_accessor :hsbc_transaction
    attr_accessor :authorization # Provided as 

    def initialize _hsbc_transaction
      self.hsbc_transaction = _hsbc_transaction
    end

    def success?
      self.hsbc_transaction.successful?
    end

  end
end
