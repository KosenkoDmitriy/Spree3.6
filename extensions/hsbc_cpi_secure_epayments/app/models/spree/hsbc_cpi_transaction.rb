# encoding: utf-8
class Spree::HsbcCpiTransaction < ActiveRecord::Base

	self.table_name = "hsbc_cpi_transactions"
	
	has_one :payment, :as => :source
	has_many :log_entries, :as => :source
	
	attr_accessor :sent_params # Just for checking when loading the marsheld data
	attr_accessor :callback_params # PArams received via the callback, these should be trusted and only contain 
	
	def gateway_url
		if production_mode? || payment.payment_method.preferred_force_production_gateway
      "https://hpp.globaliris.com/pay"

    elsif test_mode? || Rails.env.staging?
      "https://hpp.sandbox.globaliris.com/pay"

		elsif Rails.env.development?
			# Post to payment completed page, bypassing gateway
			"/checkout/hsbc_cpi_payment_completed/#{self.id}"

		else 
	    	nil
		end
	end

	attr_accessible :order_hash, :purchase_amount, :purchase_currency, :transaction_mode, :transaction_type, 
	:cpi_direct_result_url, :cpi_return_url, :store_front_id, :user_id, :order_description, 
	:cpi_results_code, :cpi_results_order_hash, :processed_at, 
	:cpi_sent_params, :cpi_callback_params, :cpi_return_params
	
  def gateway_data
    Hash.new.tap do |data|
      data["MERCHANT_ID"] = self.store_front_id
      data["ORDER_ID"] = self.order_id_for_gateway
      data["AMOUNT"] = (self.purchase_amount * 100).to_i
      data["CURRENCY"] = self.purchase_currency
      data["TIMESTAMP"] = self.created_at.strftime("%Y%m%d%H%M%S")

      # 1 capture payment in next batch
      # 0 use RealControl App to manually settle payment when shipped
      data["AUTO_SETTLE_FLAG"] = 0

      data["MERCHANT_RESPONSE_URL"] = self.cpi_direct_result_url

      data["SHA1HASH"] = HsbcOrderSignature.new(data, payment.payment_method.preferred_hsbc_cpi_secure_secret).sha1
    end
  end

  def order_id_for_gateway
    "#{self.transaction_mode}#{self.id}"
  end
	
	# Process the results from the Callback
	def valid_callback?
		load_callback_params_snapshot if callback_params.nil? 
		
		valid_result = self.methods.select{ |m| m.match(/^valid_callback_.+\?$/) }.all?{ |v| 
				result = self.send(v)
				self.log_entries.create(:details => "#{v}: #{result}")
				(result == true)
			}
		
		if valid_result
			self.log_entries.create(:details => "Callback validated unsuccessfully")
		else
			self.log_entries.create(:details => "Callback is not valid")
		end
		
		valid_result
	end

	def valid_callback_hash?
    HsbcOrderSignature.new(callback_params, payment.payment_method.preferred_hsbc_cpi_secure_secret).valid_response?
	end

	def valid_callback_order_id?
		self.order_id_for_gateway == callback_params["ORDER_ID"].to_s
	end

	def valid_callback_merchant_id?
		self.store_front_id.to_s == callback_params["MERCHANT_ID"].to_s
	end

	def valid_callback_cpi_results_code?
		callback_params["RESULT"].match(/^[0-9]+$/) != nil
	end
	
	# Stores the Transaction data from the callback params. Note this does not process the payment.
	def process_transaction_callback!
		load_callback_params_snapshot if callback_params.nil? 
		
		self.cpi_results_code = extract_cpi_results_code_from_params callback_params
		self.processed_at = Time.now
		self.save
	end
	
	# To be called from the payment as part of the order completing
	def process! payment
    pending_payment!(payment) and return if self.make_pending_payment?
		log_entries.create :details => "Processing! HSBC #{self.id}"
		
		process_transaction_callback! if !processed? && has_recevied_callback_params?
		
		if successful?
			log_entries.create :details => "Processing success! HSBC #{cpi_results_code} #{results_message}"
			payment.complete!
		else
			log_entries.create :details => "Processing failed! HSBC #{cpi_results_code} #{results_message}"
			payment.fail!
		end
	end
	def processed?
		self.processed_at.present?
	end

	def process_for_development!
		self.processed_at = Time.now
		self.cpi_results_code = "00"
		self.save
	end

  def make_pending_payment?
    self.transaction_type.blank?
  end
  def pending_payment! payment
    log_entries.create :details => "Processing Pending HSBC Payment"
    self.purchase_amount = payment.amount
    self.transaction_type = "Pending"
    self.save
  end
	
	def successful?
    self.cpi_results_code == "00" || self.cpi_results_code == "0"
	end

  def pending_fraud_review?
    self.cpi_results_code == "9"
  end
	
	def production_mode?
		self.transaction_mode == "P"
	end

  def test_mode?
    self.transaction_mode == "T"
  end
	
	def results_message
    case cpi_results_code.to_s
    when "0", "00" then "Transaction approved. Thank you for shopping with us."
    when /1.+/ then "Transaction declined. Please try again, or get in contact." #A failed transaction
    when /2.+/ then "Transaction declined. Please try again, or get in contact." # Error with bank systems
    when /3.+/ then "Transaction declined. Please try again, or get in contact." # Error with Realex Payments systems
    # when /4.+/ then ""
    when /5.+/ then "Transaction declined. Please try again, or get in contact." # Incorrect XML message formation or content
    when /6.+/ then "Transaction declined. Please try again, or get in contact." # Client deactivated
    # when /7.+/ then ""
    # when /8.+/ then ""
    # when /9.+/ then ""
		else
			"Payment is Pending"
		end

	end
	
	def extract_cpi_results_code_from_params params
    params["RESULT"].blank? ? nil : params["RESULT"]
	end
	
	def store_sent_params_snapshot!
		self.update_attribute :cpi_sent_params, gateway_data.to_json
	end

	def load_sent_params_snapshot
    self.sent_params = JSON.parse(self.cpi_sent_params)
  rescue
		self.sent_params = Marshal.load(self.cpi_sent_params)
	end
	
  def has_recevied_callback_params?
    !cpi_callback_params.blank?
  end

	def store_callback_params_snapshot!
		self.update_attribute :cpi_callback_params, callback_params.to_json

	end

	def load_callback_params_snapshot
		self.callback_params = JSON.parse(self.cpi_callback_params)
  rescue
		self.callback_params = Marshal.load(self.cpi_callback_params)
	end
	
	def store_returned_params_snapshot!
		self.update_attribute :cpi_return_params, returned_params.to_json
	end

	def load_returned_params_snapshot
		self.returned_params = JSON.parse(self.cpi_return_params)
  rescue
		self.returned_params = Marshal.load(self.cpi_return_params)
	end
	
  def actions
    ["capture", "void"]
  end

  def can_capture? payment
    self.transaction_type == "Auth" && ["processing", "pending"].include?(payment.state)
  end

  def can_void? payment
    !["checkout", "failed", "void"].include?(payment.state)
  end

  def void paymant
    log_entries.create :details => "Voiding HSBC Payment"
    self.transaction_type = "Void"
    self.cpi_results_code = nil
    if payment.processing?
      payment.fail
    else
      payment.void
    end
  end
end
