Spree::Product.class_eval do

	# attr_accessible :description_details, :description_technique

	validates_presence_of :tax_category_id, on: :update

	# scope :related_to, lambda{ |product|
	# 	where("spree_products.id != :product_id", :product_id => product.id).order("RAND()").limit(4)
	# }

end
