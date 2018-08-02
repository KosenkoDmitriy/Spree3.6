class HsbcCpiTransaction < ActiveRecord::Base

  # CPI Change to Gateway URLS
  # "https://www.cpi.hsbc.com/servlet" => "https://cpi.globaliris.com/servlet"
  # "https://www.secure-epayments.hsbc.com" => "https://realcontrol.globaliris.com"
	
	CPI_CALLBACK_FIELDS = ["CpiResultsCode", "PurchaseDate", "MerchantData", "OrderHash", "OrderId", "PurchaseAmount", "PurchaseCurrency", "ShopperEmail", "StorefrontId"]
	CPI_RETURNED_FIELDS = ["CpiResultsCode", "PurchaseDate", "MerchantData", "OrderHash", "OrderId", "PurchaseAmount", "PurchaseCurrency", "ShopperEmail", "StorefrontId"]
	
	has_one :payment, :as => :source
	has_many :log_entries, :as => :source
	
	attr_accessor :sent_params # Just for checking when loading the marsheld data
	attr_accessor :callback_params # PArams received via the callback, these should be trusted and only contain 
	attr_accessor :returned_params
	
	def cpi_gateway_url
		if production_mode? || payment.payment_method.preferred_force_production_gateway
			"https://cpi.globaliris.com/servlet"
		else
			#"https://www.uat.cpi.secureepayments.hsbc.com/servlet"
      nil
		end
	end
	
	def cpi_post_data opts = Hash.new
		
		opts[:include_order_hash] ||= false
		
		post_data = Hash.new
		
		post_data["CpiDirectResultUrl"] = self.cpi_direct_result_url #"https://50.56.83.156/hsbc_cpi_notify/2",
		post_data["CpiReturnUrl"] = self.cpi_return_url #https://50.56.83.156/checkout/hsbc_cpi_payment_completed/2
		
		post_data["Mode"] = self.transaction_mode
		post_data["OrderDesc"] = (self.order_description || "Order from SoulPad [#{self.id}]")[0..54]
		post_data["OrderHash"] = self.order_hash if opts[:include_order_hash]
		post_data["OrderId"] = self.order_id_for_cpi # Do not use the order ID, as HSBC will issue a CPI RESULT CODE 7
		
		post_data["PurchaseAmount"] = (self.purchase_amount * 100).to_i
		post_data["PurchaseCurrency"] = self.purchase_currency
		post_data["StorefrontId"] = self.store_front_id
		post_data["TimeStamp"] = self.created_at.to_i * 1000 #use created_at so the hash is correct when sending #Time.now.to_i * 1000
		post_data["TransactionType"] = self.transaction_type
		#post_data[#"UserId" => self.payment.order.user.try(:id),
		
		post_data["BillingAddress1"] = (self.payment.order.bill_address.address1 || "")[0..60]
		post_data["BillingAddress2"] = (self.payment.order.bill_address.address2)[0..60] unless self.payment.order.bill_address.address2.blank?
		post_data["BillingCity"] = (self.payment.order.bill_address.city || "")[0..25]
		post_data["BillingCountry"] = self.payment.order.bill_address.country.numcode
		post_data["BillingCounty"] = (self.payment.order.bill_address.state.try(:name) || (self.payment.order.bill_address.state_name || ""))[0..25]
		post_data["BillingFirstName"] = (self.payment.order.bill_address.firstname || "")[0..32]
		post_data["BillingLastName"] = (self.payment.order.bill_address.lastname || "")[0..32]
		post_data["BillingPostal"] = (self.payment.order.bill_address.zipcode || "")[0..20]
		
		post_data["ShopperEmail"] = (self.payment.order.email || "")[0..64]

		post_data["ShippingAddress1"] = (self.payment.order.ship_address.address1 || "")[0..60]
		post_data["ShippingAddress2"] = (self.payment.order.ship_address.address2)[0..60] unless self.payment.order.ship_address.address2.blank?
		post_data["ShippingCity"] = (self.payment.order.ship_address.city || "")[0..25]
		post_data["ShippingCountry"] = self.payment.order.ship_address.country.numcode
		post_data["ShippingCounty"] = (self.payment.order.ship_address.state.try(:name) || (self.payment.order.ship_address.state_name || ""))[0..25]
		post_data["ShippingFirstName"] = (self.payment.order.ship_address.firstname || "")[0..32]
		post_data["ShippingLastName"] = (self.payment.order.ship_address.lastname || "")[0..32]
		post_data["ShippingPostal"] = (self.payment.order.ship_address.zipcode || "")[0..20]
		
		post_data
	end

  def order_id_for_cpi
    "#{self.transaction_mode}#{self.id}"
  end
	
	# Use HSBC provided C binary
	# Note Binary needs to be installed in an avaible executabele path like /usr/bin
	# For this, we're actually using the TestHash.e binary and renamed to usr/bin/hsbc_cpi_generate_hash
	# The hsbc_cpi_generate_hash binary will auto order the escaped data, so the order hash is not corrupted by the data:
	# e.g.,
	# 	`hsbc_cpi_generate_hash zEeWQNKelqPE2DRFueuDq1QrASjux2lM aaa bbb`
	# 	=> zaM6DPT7GkEJtg2OWYzSePUa0rc=
	# 	`hsbc_cpi_generate_hash zEeWQNKelqPE2DRFueuDq1QrASjux2lM bbb aaa`
	# 	=> zaM6DPT7GkEJtg2OWYzSePUa0rc=
	#
	def generate_order_hash! #data = Array.new
		escaped_data = cpi_post_data(:include_order_hash => false).map{ |a| "\"#{a.second}\"" }.join(" ")
		
		output = case Rails.env
			when "development"
				# Note is code WILL NOT WORK, as the C program hsbc_cpi_generate_hash only works on linux based machines, No love for UNIX/POSIX here :-(
				# Development Hack follows:
				"Hash value:  zaM6DPT7GkEJtg2OWYzSePUa0rc="
			else
				# Only run this on Linux machines, dont think the C bin works on UNIX/POSIX/WINDOWS
				`hsbc_cpi_generate_hash "#{payment.payment_method.preferred_hsbc_cpi_secure_secret}" #{escaped_data}` # Should return something like "Hash value:  1sMZc6TaxcMnQthq2Dp0QKe7obk="
			end
		
		self.order_hash = output.scan(/Hash\svalue:\s\s(.+)/).to_s # only need the last part
		self.save
	end
	
	# Process the results from the Callback
	def valid_callback?
		load_callback_params_snapshot if callback_params.nil? 
		
		valid_result = self.methods.select{ |m| m.match /^valid_callback_.+\?$/ }.all?{ |v| 
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
		check_hash_with_params callback_params["OrderHash"], callback_params.select{ |k,v| HsbcCpiTransaction::CPI_CALLBACK_FIELDS.include?(k.to_s) && k != "OrderHash" }.map{ |a| a.second }
	end
	def valid_callback_order_id?
		self.order_id_for_cpi == callback_params["OrderId"].to_s
	end
	#def valid_callback_purchase_amount?
	#	self.purchase_amount == (callback_params["PurchaseAmount"].to_i / 100.00)
	#end
	def valid_callback_storefront_id?
		self.store_front_id.to_s == callback_params["StorefrontId"].to_s
	end
	def valid_callback_cpi_results_code?
		callback_params["CpiResultsCode"].match(/^[0-9]+$/) != nil
	end
	
	
	def valid_return?
		#check all valid return checks
		self.methods.select{ |m| m.match /^valid_return_.+\?$/ }.all?{ |v| self.send v }
	end
	def valid_return_hash?
		check_hash_with_params returned_params["OrderHash"], returned_params.select{ |k,v| HsbcCpiTransaction::CPI_RETURNED_FIELDS.include?(k.to_s) && k != "OrderHash" }.map{ |a| a.second }
	end
	
	
	def check_hash_with_params check_hash, params
		escaped_data = params.map{ |v| "\"#{v}\"" }.join(" ")
		new_hash = case Rails.env
			when 'development' 
				"zaM6DPT7GkEJtg2OWYzSePUa0rc=" # Yep a nasty Dev Hack
			else
				output = `hsbc_cpi_generate_hash "#{payment.payment_method.preferred_hsbc_cpi_secure_secret}" #{escaped_data}`
				output.scan(/Hash\svalue:\s\s(.+)/).to_s
			end
			self.log_entries.create(:details => "Check hash #{check_hash} with data generated hash #{new_hash}")
		return (new_hash == check_hash)
	end
	
	# Stores the Transaction data from the callback params. Note this does not process the payment.
	def process_transaction_callback!
		load_callback_params_snapshot if callback_params.nil? 
		
		self.cpi_results_code = extract_cpi_results_code_from_params callback_params
		self.processed_at = Time.now
		self.save
	end
	
	# To be called from the payment as partr of the order completing
	def process! payment
    pending_payment!(payment) and return if self.make_pending_payment?
		log_entries.create :details => "Processing! HSBC #{self.id}"
		
		#load_callback_params_snapshot
		process_transaction_callback! if !processed? && has_recevied_callback_params?
		
		#payment.fail! and return unless self.valid_callback?
		
		# Update Payment
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

  def make_pending_payment?
    self.transaction_type.blank?
  end
  def pending_payment! payment
    log_entries.create :details => "Processing Pending HSBC Payment"
    self.purchase_amount = payment.amount
    self.transaction_type = "Pending"
    self.save
    #payment.complete!
    #payment.started_processing
  end
	
	def successful?
		self.cpi_results_code == 0
	end

  def pending_fraud_review?
    self.cpi_results_code == 9
  end
	
	def production_mode?
		self.transaction_mode == "P"
	end
	
	def results_message
		case cpi_results_code
		when 0 then "Transaction approved. Thank you for shopping with us."
		when 1 then "Transaction cancelled. Changed your mind? That's okay."
		when 2 then "Transaction declined. Please try again, or get in contact."
		when 3 then "Transaction declined. Please try again, or get in contact."
		when 4 then "Transaction declined. Please try again, or get in contact."
		when 5 then "Transaction declined. Please try again, or get in contact."
		when 6 then "Transaction declined. Please try again, or get in contact."
		when 7 then "Transaction declined. Please try again, or get in contact."
		when 8 then "Transaction declined. Please try again, or get in contact."
		when 9 then "Something's not quite right. Your payment has been successfully allocated to SoulPad Ltd by your card issuer, but is in a holding area pending SoulPad's acceptance of it. This could be for a number of reasons. A SoulPad Representative will contact you shortly by telephone or email to resolve the matter as quickly as possible."
		when 10 then "Transaction declined. Please try again, or get in contact."
		when 11 then "Transaction declined. Please try again, or get in contact."
		when 12 then "Transaction declined. Please try again, or get in contact."
		when 13 then "Transaction declined. Please try again, or get in contact."
		when 14 then "Transaction declined. Please try again, or get in contact."
		when 15 then "Transaction declined. Please try again, or get in contact."
		when 16 then "Transaction declined. Please try again, or get in contact."
		else
			# Missing or 
			"Payment is Pending"
		end
	end
	# 0 The transaction was approved.
	# 1 The user cancelled the transaction.
	# 2 The processor declined the transaction for an unknown reason.
	# 3 The transaction was declined because of a problem with the card. For example, an invalid card number or expiration date was specified.
	# 4 The processor did not return a response.
	# 5 The amount specified in the transaction was either too high or too low for the processor.
	# 6 The specified currency is not supported by either the processor or the card.
	# 7 The order is invalid because the order ID is a duplicate.
	# 8 The transaction was rejected by FraudShield.
	# 9 The transaction was placed in Review state by FraudShield (see note 1 below).
	# 10 The transaction failed because of invalid input data.
	# 11 The transaction failed because the CPI was configured incorrectly.
	# 12 The transaction failed because the Storefront was configured incorrectly.
	# 13 The connection timed out.
	# 14 The transaction failed because the cardholder’s browser refused a cookie.
	# 15 The customer’s browser does not support 128-bit encryption.
	# 16 The CPI cannot communicate with the Payment Engine.
	
	def extract_cpi_results_code_from_params params
		case params["CpiResultsCode"].class.to_s
		when "NilClass"
			nil #params["CpiResultsCode"]
		when "String"
			params["CpiResultsCode"].blank? ? nil : params["CpiResultsCode"].to_i
		when "Fixnum"
			params["CpiResultsCode"]
		else
			nil
		end
	end
	
	def store_sent_params_snapshot!
		self.update_attribute :cpi_sent_params, Marshal.dump(cpi_post_data(:include_order_hash => true))
	end
	def load_sent_params_snapshot
		self.sent_params = Marshal.load(self.cpi_sent_params)
	end
	
  def has_recevied_callback_params?
    !cpi_callback_params.blank?
  end
	def store_callback_params_snapshot!
		self.update_attribute :cpi_callback_params, Marshal.dump(callback_params)
	end
	def load_callback_params_snapshot
		self.callback_params = Marshal.load(self.cpi_callback_params)
	end
	
	def store_returned_params_snapshot!
		self.update_attribute :cpi_return_params, Marshal.dump(returned_params)
	end
	def load_returned_params_snapshot
		self.returned_params = Marshal.load(self.cpi_return_params)
	end
	
  def actions
    ["approve", "void"]
  end

  def can_approve? payment
    self.transaction_type == "Pending" && ["processing", "pending"].include?(payment.state)
  end

  def approve payment
    log_entries.create :details => "Processing Pending HSBC Payment"
    self.transaction_type = "Capture"
    self.processed_at = Time.now
    self.cpi_results_code = 0
    payment.complete
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
