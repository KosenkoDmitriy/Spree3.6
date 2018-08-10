module BasketSummary
	extend ActiveSupport::Concern

	included do
		before_action :find_basket
	end

	def find_basket
		session_order = Spree::Order.find(session[:order_id]) unless session[:order_id].blank?

		if session_order && session_order.try(:completed?)
			session[:order_id] = nil
		end

		@basket = Spree::Order.find_or_create_by_id(session[:order_id]) unless session[:order_id].blank?
		@basket ||= Spree::Order.new
	end
end
