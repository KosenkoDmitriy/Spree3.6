Rails.application.routes.draw do
	
	#resources :orders do
	#	resource :checkout, :controller => 'checkout' do
	#		member do 
	#			get :hsbc_cpi_payment
	#			post :hsbc_cpi_payment_completed
	#		end
	#	end
	#end
	
	# Routes as defined by spree core
	#match '/checkout/update/:state' => 'checkout#update', :as => :update_checkout
  #match '/checkout/:state' => 'checkout#edit', :as => :checkout_state
  #match '/checkout' => 'checkout#edit', :state => 'address', :as => :checkout
	match '/checkout/hsbc_cpi_payment' => 'checkout#hsbc_cpi_payment', :via => [:get], :as => "checkout_hsbc_cpi_payment"
	match '/checkout/hsbc_cpi_payment_completed/:transaction_id' => 'checkout#hsbc_cpi_payment_completed', :via => [:post], :as => "checkout_hsbc_cpi_payment_completed"
	
	# CallBack Notifier
	match '/hsbc_cpi_notify/:transaction_id' => 'hsbc_cpi_callbacks#notify', :via => [:post], :as => "hsbc_cpi_notify"
	
	
	
end
