Spree::ProductsController.class_eval do
  # helper 'spree/products'

  # def index
  #   @searcher = Spree::Config.searcher_class.new(params)
  #   @searcher.current_user = try_spree_current_user
  #   @searcher.current_currency = current_currency
  #   @products = @searcher.retrieve_products#.order("spree_prices.amount DESC")
  # end

  def image
    @image = @product.images.find(params[:image_id])
  end

  def sale
    @products = Spree::Product.sales.order("spree_variants.sale_price ASC")
    redirect_to root_url if @products.empty?
  end

end
