Spree::Product.class_eval do

	# belongs_to :spree_variant
	# delegate :main_price, :sale_price, :is_on_sale?, to: :spree_variant, allow_nil: true
	delegate :main_price, :sale_price, :main_price=, :sale_price=, :is_on_sale?, to: :master, allow_nil: true

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

	def max_price
		variants_including_master.map(&:price).max
	end

	def max_main_price
		variants_including_master.map(&:main_price).max
	end
end
