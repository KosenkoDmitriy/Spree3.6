class FeaturesEngine::Admin::FeaturesController < Spree::Admin::BaseController

  def index
    @q = Feature.ransack(params[:q])
    @features= @q.result.
         page(params[:page]).
         per(Spree::Config[:admin_products_per_page])
  end

  def show
    @feature = Feature.find(params[:id])
    @product = @feature.spree_product.nil? ? "None" : @feature.spree_product.name
    respond_to do |format|
      format.html
    end
  end

  def new
    @feature = Feature.new

    respond_to do |format|
      format.html
    end
  end

  def create
    @feature = Feature.new(feature_params)

    respond_to do |format|
      if @feature.save
        format.html  { redirect_to(admin_feature_url(@feature),
                                   :notice => 'Feature was successfully created.') }
      else
        format.html  { render :action => "new" }
      end
    end
  end

  def edit
    @feature = Feature.find(params[:id])

    respond_to do |format|
      format.html  # new.html.erb
    end
  end

  def update
    @feature = Feature.find(params[:id])

    respond_to do |format|
      if @feature.update_attributes(feature_params)
        format.html  { redirect_to(admin_feature_url(@feature),
                                   :notice => 'Feature was successfully updated.') }
      else
        format.html  { render :action => "edit" }
      end
    end
  end

  def destroy
    @feature = Feature.find(params[:id])

    respond_to do |format|
      if @feature.destroy
        format.html { redirect_to admin_features_url }
      else
        format.html { redirect_to admin_feature_url(@feature), :error => "Feature was not deleted." }
      end
    end
  end

  protected

  def feature_params
    params.require(:feature).permit(:title, :description, :link, :product_id, :enabled, :shop_enabled, :attachment)
  end

end
