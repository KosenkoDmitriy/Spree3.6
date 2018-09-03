Spree::Variant.class_eval do

	# attr_accessible :main_price, :sale_price
	# belongs_to :product
	# delegate :master, to: :product, allow_nil: true

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
