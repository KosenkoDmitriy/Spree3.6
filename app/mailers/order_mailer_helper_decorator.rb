Spree::OrderMailer.class_eval do
	add_template_helper(OrderMailerHelper)
	add_template_helper(CheckoutHelper)
end
