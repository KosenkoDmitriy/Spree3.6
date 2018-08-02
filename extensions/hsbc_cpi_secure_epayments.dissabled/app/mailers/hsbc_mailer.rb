class HsbcMailer < ActionMailer::Base
  helper "spree/base"

	# Spree Handles adding all the "From" and overriding "To" for Dev Envs

  def fraud_notification(hsbc_transaction)
    @order = hsbc_transaction.payment.order
    #@shipment = shipment
    #subject = (resend ? "[RESEND] " : "")
    #subject += "#{Spree::Config[:site_name]} Shipment Notification ##{shipment.order.number}"
    mail(:to => "enquiries@soulpad.co.uk",
         :subject => "SoulPad: Fraud Notification #{@order.number}")
  end

end
