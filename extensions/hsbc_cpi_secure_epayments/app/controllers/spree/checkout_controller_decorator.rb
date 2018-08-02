Spree::CheckoutController.class_eval do
	skip_before_filter :authenticate_beta, :only => [:hsbc_cpi_payment, :hsbc_cpi_payment_completed]
	skip_before_filter :load_order_with_lock, :only => [:hsbc_cpi_payment_completed]

	skip_before_filter :ensure_order_not_completed, :only => [:hsbc_cpi_payment, :hsbc_cpi_payment_completed]
	skip_before_filter :ensure_checkout_allowed, :only => [:hsbc_cpi_payment, :hsbc_cpi_payment_completed]
	skip_before_filter :ensure_sufficient_stock_lines, :only => [:hsbc_cpi_payment, :hsbc_cpi_payment_completed]
	skip_before_filter :ensure_valid_state, :only => [:hsbc_cpi_payment, :hsbc_cpi_payment_completed]
  
  skip_before_filter :associate_user, :only => [:hsbc_cpi_payment, :hsbc_cpi_payment_completed]
  skip_before_filter :check_authorization, :only => [:hsbc_cpi_payment, :hsbc_cpi_payment_completed]
  skip_before_filter :check_registration, :only => [:hsbc_cpi_payment, :hsbc_cpi_payment_completed]
	skip_before_filter :setup_for_current_state, :only => [:hsbc_cpi_payment, :hsbc_cpi_payment_completed]

  before_filter :redirect_to_hsbc_cpi_form_if_needed, :only => [:update]
	after_filter :log_order_state, :only => [:update]

	#before_filter :before_hsbc_payment, :only => [:before_payment]

	# Fired as soon as the customer selects to use HSBC as the Payment Method
	def hsbc_cpi_payment
		load_order
		
		# Get all options for Order/Payment
		
		# Setup order.payment and order.payment.paymentmethod
		
		@hsbc_payment_method = Spree::PaymentMethod.find(params[:payment_method_id])
		
		@hsbc_transaction = Spree::HsbcCpiTransaction.create # Must create so we get a constant created_at time for orde hash gen
		
		@payment = @order.payments.create(
			:amount => @order.total,
			:source => @hsbc_transaction,
			:payment_method_id => @hsbc_payment_method.id
		)
		
		#hsbc_payment_method = payment.payment_method
		
		#hsbc_cpi_transaction = 
		
		
		@hsbc_transaction.cpi_direct_result_url = hsbc_cpi_secure_epayments.hsbc_cpi_notify_url(:transaction_id => @hsbc_transaction)
		# @hsbc_transaction.cpi_return_url = hsbc_cpi_secure_epayments.checkout_hsbc_cpi_payment_completed_url(:transaction_id => @hsbc_transaction) #order_url(@order)

		@hsbc_transaction.purchase_amount = @order.total.round(2)
		@hsbc_transaction.purchase_currency = ENV['CURRENCY_CODE']
		
		@hsbc_transaction.transaction_mode = (@hsbc_payment_method.preferred_transaction_mode || "T") #T / P
		@hsbc_transaction.transaction_type = "Auth" #'Auth' or 'Capture'
		#An Auth transaction places a reserve on the cardholders open-to-buy balance, the cardholders available balance remains unchanged. Once the goods have been confirmed as “shipped”, you will use the Virtual Terminal to mark the order as “shipped”. This process then automatically marks the funds ready for settlement. (This corresponds to a “PreAuth” in the Virtual Terminal.)
		#A Capture transaction verifies the cardholder’s account to be in good standing, and automatically marks the funds ready for settlement. This is typically used for goods that do not need to be physically shipped (for example, a software download). (This corresponds to an “Auth” in the Virtual Terminal.)
		
		@hsbc_transaction.store_front_id = @hsbc_payment_method.preferred_storefront_id
		
		
		# @hsbc_transaction.generate_order_hash!
		
		@hsbc_transaction.log_entries.create do |entry|
			entry.details = "Transaction ready: #{@hsbc_transaction.order_hash}"
		end
		@hsbc_transaction.store_sent_params_snapshot!
		
		#payment.source = hsbc_transaction
		@payment.save
		#@payment.started_processing!
		
		# render the page as normal, however, the page will count down from 5 seconds then auto submit a POST to HSBC
		response.charset = "iso-8859-1"
	end


	# PRocess here and check with the callback notifier
#	def hsbc_cpi_payment_completed
#		@hsbc_transaction = Spree::HsbcCpiTransaction.find params[:transaction_id]
#		@hsbc_transaction.returned_params = params
#		@hsbc_transaction.store_returned_params_snapshot!
#		@hsbc_transaction.log_entries.create do |entry| 
#			entry.details = "HSBC Transaction Returned"
#		end
#
#		if Rails.env.development?
#			# Massive Hack to force transactions in development mode
#			@hsbc_transaction.process_for_development!
#		end
#		
#		if @hsbc_transaction.processed? && (@hsbc_transaction.successful? || @hsbc_transaction.pending_fraud_review?)
#			
#			@order = @hsbc_transaction.payment.order # for order details
#			until @order.state == "complete"
#				@hsbc_transaction.log_entries.create do |entry|
#					entry.details = "HSBC Transcation Processing Order at #{@order.state}"
#				end
#              @order.next
#            end
#			
#            if @hsbc_transaction.pending_fraud_review?
#              @hsbc_transaction.log_entries.create do |entry|
#              	entry.details = "HSBC Transcation is pending Fraud Review"
#              end
#            else
#              @hsbc_transaction.log_entries.create do |entry| 
#              	entry.details = "HSBC Transcation was successful"
#              end
#            end
#			redirect_to order_url(@order, :checkout_complete => "true") and return
#			
#		else
#			# Transaction has failed, dump user on page and explain why. Keep cart as it so user can try again
#			@hsbc_transaction.log_entries.create do |entry| 
#				entry.details = "HSBC Transcation was not successful"
#			end
#			return
#		end
#
#	end


	protected
	
	# Catch if user has clicked 'save and continue' instead of the HSBC link
	# Should apply coupons then redirect to hsbc_cpi_payment
	def redirect_to_hsbc_cpi_form_if_needed
		return true if params[:state] != "payment" # only redirect to hsbc if we're on the payment step
		# Rails.logger.debug "@@@@@@@ redirect_to_hsbc_cpi_form_if_needed? param:#{params[:state]} order:#{@order.state}: "
		# if params[:order] && params[:order][:coupon]
		# 	@order.update_attributes(object_params)
		# 	@order.process_coupon_code
		# end
		# load_order
		# payment_method = Spree::PaymentMethod.find(params[:order][:payments_attributes].first[:payment_method_id])
		
		if payment_method.kind_of? Spree::PaymentMethod::HsbcCpiSecureEpayment
			redirect_to checkout_hsbc_cpi_payment_url(:payment_method_id => payment_method) and return
		end
		
		return true # to ensure the before filter doesnot cancel the page action
	end
	
	def log_order_state
		Rails.logger.debug "@@@@@@ LOG A TON OF ORDER STATE: param:#{params[:state]} o:#{@order.state}"
	end

end
