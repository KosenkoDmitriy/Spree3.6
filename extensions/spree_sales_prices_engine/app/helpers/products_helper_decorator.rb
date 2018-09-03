Spree::ProductsHelper.class_eval do

	def silly_helper
		"Just'abit silly"
	end

	def main_product_price(product_or_variant, options={})
	    options.assert_valid_keys(:format_as_currency, :show_vat_text)
	    options.reverse_merge! :format_as_currency => true, :show_vat_text => Spree::Config[:show_price_inc_vat]

	    amount = product_or_variant.main_price
	    amount += Calculator::Vat.calculate_tax_on(product_or_variant) if Spree::Config[:show_price_inc_vat]
	    options.delete(:format_as_currency) ? format_price(amount, options) : amount
	end

end