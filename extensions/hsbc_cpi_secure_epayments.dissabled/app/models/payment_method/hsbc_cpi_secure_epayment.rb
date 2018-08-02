module PaymentMethod
	class HsbcCpiSecureEpayment < Spree::PaymentMethod
		
		preference :hsbc_cpi_secure_secret, :string
		preference :storefront_id, :string
		preference :transaction_mode, :string # T or P
		preference :force_production_gateway, :boolean # Used to force the use of the production URL (to bypass staging site)
		
	  def payment_source_class
	    HsbcCpiTransaction
	  end
	end
end