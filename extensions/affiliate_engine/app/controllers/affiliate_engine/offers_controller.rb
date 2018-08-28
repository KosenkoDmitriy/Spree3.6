class AffiliateEngine::OffersController < Spree::BaseController

  before_action do
    @selected_nav = :about
  end

  def index
    @query = Offer.ransack(params[:q])
    @query.sorts = ['created_at desc', 'title asc'] if @query.sorts.empty?
    @offers= @query.result.
        enabled.
        page(params[:page]).
        per(10)
    self.title = "Offers"
    @affiliates = Gmaps4rails.build_markers(Offer.enabled.all) do |o,m|
      m.lat o.latitude
      m.lng o.longitude
      m.infowindow render_to_string(:partial => "layouts/infowindow", locals: { object: o})
    end
  end

  def show
    @offer = Offer.find_by_slug(params[:id])
    if @offer.nil? || @offer.enabled == false
      redirect_to action: :index
      return
    end
    @hash = Gmaps4rails.build_markers(@offer) do |o,m|
      m.lat o.latitude
      m.lng o.longitude
    end
    self.title = @offer.title
    respond_to do |format|
      format.html # index.html.erb
    end
  end

end
