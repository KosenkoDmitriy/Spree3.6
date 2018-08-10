module CheckoutHelper

	def sum_shipping_rates(order)
		shipping_method = @order.adjustments.eligible.where(originator_type: 'Spree::ShippingMethod')
		shipping_method_array = shipping_method.all.map(&:display_amount)
		shipping_method_array = shipping_method_array.map {|spree_money| (spree_money.money.fractional) / 100.0 }
		shipping_method_array.inject(:+)
	end

end
