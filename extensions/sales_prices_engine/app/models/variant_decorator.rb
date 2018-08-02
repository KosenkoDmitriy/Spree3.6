Spree::Variant.class_eval do

	attr_accessible :main_price, :sale_price

	before_validation do
		self.price = if self.sale_price.blank?
			self.main_price
		else
			self.sale_price
    end
	end

	def is_on_sale?
		!self.sale_price.blank?
	end

end