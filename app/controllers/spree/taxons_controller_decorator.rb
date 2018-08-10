Spree::TaxonsController.class_eval do
  
  def show
    @taxon = Spree::Taxon.find_by_permalink!(params[:id])
    return unless @taxon

    @searcher = build_searcher(params.merge(:taxon => @taxon.id))
    @products = @searcher.retrieve_products.order("spree_variants.main_price ASC")
  end
  
end
