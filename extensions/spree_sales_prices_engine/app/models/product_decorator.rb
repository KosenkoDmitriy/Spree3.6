Spree::Product.class_eval do

	# attr_accessible :main_price, :sale_price
	# delegate_belongs_to :master, :main_price, :sale_price, :is_on_sale?

	belongs_to :spree_variant
	# delegate :main_price, :sale_price, :is_on_sale?, to: :spree_variant, allow_nil: true

	delegate :main_price, :sale_price, :main_price=, :sale_price=, :is_on_sale?, to: :master, allow_nil: true
	before_validation do
		self.price = if self.sale_price.blank?
			self.main_price
		else
			self.sale_price
    end
		# self.price = self.sale_price.blank? ?	self.main_price :	self.sale_price
		# self.price = self.sale_price.blank? ?	self.main_price.blank? ? 0.00 : self.main_price :	self.sale_price
		# self.price = self.main_price.blank? ? 0.00 : self.main_price
	end

	def self.sales
		active.joins(:variants_including_master).where("spree_variants.sale_price >= ? AND spree_variants.deleted_at IS NULL", 0)
	end

	def is_on_sale?
		variants_including_master.collect(&:sale_price).any?
	end

	def cheapest_price
		variants_including_master.map(&:price).min
	end

	def cheapest_main_price
		variants_including_master.map(&:main_price).min
	end
end