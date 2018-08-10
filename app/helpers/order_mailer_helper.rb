module OrderMailerHelper
	
	def tax_label(order)
		tax = order.tax_for_order
    if tax.first
      label = tax.first.label
      'Includes ' + label
    end
	end
	
	def sum_tax(order)
		tax = order.tax_for_order
		tax_array = tax.all.map(&:display_amount)
		tax_array = tax_array.map {|spree_money| (spree_money.money.fractional) / 100.0 }
		tax_array.inject(:+)
	end

end
