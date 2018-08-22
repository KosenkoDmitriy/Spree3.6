Spree::ProductsHelper.class_eval do

	def product_price_starts_at(product, options={})
		current_currency = current_currency || Spree::Config[:currency]
	    options.assert_valid_keys(:format_as_currency, :show_vat_text)
	    #options.reverse_merge! :format_as_currency => true, :show_vat_text => Spree::Config[:show_price_inc_vat]

	    #amount = product.price
	    #amount += Spree::Calculator::Vat.calculate_tax_on(product) if Spree::Config[:show_price_inc_vat]

		if product.variants.count > 0 && product.cheapest_price
			price_with_taxes = price_with_tax_for_product(product.cheapest_price, product)
      "From: #{Spree::Money.new price_with_taxes, {:currency => current_currency} }"
		else
      price_with_taxes = price_with_tax_for_product(product.price, product)
			"Price: #{Spree::Money.new price_with_taxes, {:currency => current_currency} }"
		end
	end

  def price_with_tax_for_product price, product
    #Spree::TaxRate.where(tax_category_id: v.tax_category_id, zone_id: Spree::Zone.default_tax.id).first.amount.to_f + 1) * v.price
    (Spree::TaxRate.where(tax_category_id: product.tax_category_id, zone_id: Spree::Zone.default_tax || Spree::Zone.first).first.try(:amount).try(:to_f) || 0 + 1) * price unless price.nil?
  end

  def line_item_description(variant)
    description = variant.product.description
    if description.present?
      raw(strip_tags(description).split(" ")[0..20].join(" ") << "...")
    else
      Spree.t(:product_has_no_description)
    end
  end

end
