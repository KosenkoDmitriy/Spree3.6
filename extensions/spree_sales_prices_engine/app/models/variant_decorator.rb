Spree::Variant.class_eval do

	before_validation do
		self.price = if self.sale_price.blank?
			self.main_price = self.main_price.present? ? self.main_price : self.price
		else
			self.sale_price
    end
	end

	def is_on_sale?
		!self.sale_price.blank?
	end

end
