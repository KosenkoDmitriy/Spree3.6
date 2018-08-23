Spree::LineItem.class_eval do

	# takes the first Spree::TaxRate - any duplicate entries should be the same rate.
  def tax_for_line_item(order, options = {})
		@klass = options.fetch(:tax_klass, Spree::TaxRate)
		
		tax = @klass.tax_rate(order.tax_zone, tax_category).first
		tax.amount
  end
	
	def price_inc_tax(order, options = {})
		@precision = options.fetch(:precision, 2)
		@price = options.fetch(:price, price)
		
		tax_rate = tax_for_line_item(order)
		price_inc_tax = @price + (@price * tax_rate)
		price_inc_tax.round(@precision)
	end
	
end
