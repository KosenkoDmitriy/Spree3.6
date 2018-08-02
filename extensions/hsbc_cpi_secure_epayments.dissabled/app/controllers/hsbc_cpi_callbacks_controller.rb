class HsbcCpiCallbacksController < Spree::BaseController

	skip_before_filter :authenticate_beta
	skip_before_filter :verify_authenticity_token

	ssl_required

	def notify
		#@order = Order.find_by_number(params["OrderId"])
		#
		@hsbc_cpi_transaction = HsbcCpiTransaction.find params[:transaction_id]
		@hsbc_cpi_transaction.callback_params = params
		@hsbc_cpi_transaction.store_callback_params_snapshot!
		@hsbc_cpi_transaction.process_transaction_callback!
		@hsbc_cpi_transaction.save
		
		if @hsbc_cpi_transaction.valid_callback? && @hsbc_cpi_transaction.processed? && (@hsbc_cpi_transaction.successful? || @hsbc_cpi_transaction.pending_fraud_review?)
        @order = @hsbc_cpi_transaction.payment.order # for order details
        until @order.state == "complete"
          @hsbc_cpi_transaction.log_entries.create(:details => "Processing Order at #{@order.state}")
          if @order.next!
            # state_callback(:after) # DO NOT FIRE, IN FACT, JUST DO NOTHING
          end
        end
        
        @hsbc_cpi_transaction.log_entries.create(:details => "HSBC Transcation was successful")

        HsbcMailer.fraud_notification(@hsbc_cpi_transaction) if @hsbc_cpi_transaction.pending_fraud_review?
			
		else
			# Transaction has failed, dump user on page and explain why. Keep cart as it so user can try again
			@hsbc_cpi_transaction.log_entries.create(:details => "HSBC Transcation was not successful")
		end

		render :text => "OKAY"
  end

	private
	
	def retrieve_details
		#@order = Order.find_by_number(params["OrderId"])
		#
		#@payment = @order.payments.where(:state => "pending", :source_type => "HsbcCpiTransaction").try(:first)
	  #
		##if @order
		##	@payment = @order.payments.where(:state => "pending", :source_type => "PaypalAccount").try(:first)
		##	
		##	@payment.try(:payment_method).try(:provider) #configures ActiveMerchant
	  ##end
	end

end
