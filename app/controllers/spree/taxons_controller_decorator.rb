Spree::TaxonsController.class_eval do

  def show
    @taxon = Spree::Taxon.find_by!(permalink: params[:id])
    return unless @taxon

    @searcher = build_searcher(params.merge(taxon: @taxon.id, include_images: true))
    @products = @searcher.retrieve_products#.order("spree_variants.main_price ASC")
    @taxonomies = Spree::Taxonomy.includes(root: :children)
  end

end
