class AffiliateEngine::Admin::OffersController < Spree::Admin::BaseController

  def index
    @offers = Offer.page(params[:page]).per(Spree::Config[:admin_products_per_page])
  end

  def new
    @offer = Offer.new
    6.times {@offer.offer_images.build}
  end

  def create
    @offer = Offer.new(offer_params)
    respond_to do |format|
      if @offer.save
        format.html  { redirect_to(admin_offers_url, :notice => 'Offer was successfully created.') }
      else
        format.html  { render :action => "new" }
      end
    end
  end

  def edit
    @offer = Offer.find(params[:id])
    (6 - @offer.offer_images.count).times {@offer.offer_images.build}
  end

  def update
    @offer = Offer.find(params[:id])

    respond_to do |format|
      if @offer.update_attributes(offer_params)
        format.html  { redirect_to(admin_offers_url,	:notice => 'Offer was successfully updated.') }
      else
        format.html  { render :action => "edit" }
      end
    end
  end


	def destroy
		@offer = Offer.find(params[:id])

		respond_to do |format|
			if @offer.destroy
        format.html { redirect_to admin_offers_url, :notice => "Offer was successfully deleted." }
			else
        format.html { redirect_to admin_offers_url(@offer), :error => "Offer was not deleted." }
			end
		end
	end

  private
  def offer_params
    params.require(:offer).permit(:slug, :contact_tel, :address, :latitude, :longitude, :postcode, :offer, :title, :location, :contact_email, :enabled, :view_by_appt, :description, :image, :website, :offer_images_attributes)
    # offer_images :image, :caption
  end
end
