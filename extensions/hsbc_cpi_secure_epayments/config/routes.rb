HsbcCpiSecureEpayments::Engine.routes.draw do

	# Checkout  Methods
	get '/checkout/hsbc_cpi_payment', :to => "checkout#hsbc_cpi_payment", :as => "checkout_hsbc_cpi_payment"
	post '/checkout/hsbc_cpi_payment_completed/:transaction_id', :to =>'checkout#hsbc_cpi_payment_completed', :as => "checkout_hsbc_cpi_payment_completed"
	
	# CallBack Notifier
	post '/hsbc_cpi_notify/:transaction_id', :to => 'hsbc_cpi_callbacks#notify', :as => "hsbc_cpi_notify"
	
end
