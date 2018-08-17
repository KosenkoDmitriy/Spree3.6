class DynamicContentManagementEngine::Admin::DynamicDataController < Spree::Admin::BaseController

  def index
    @dynamic_data = DynamicDatum.page(params[:page]).per(Spree::Config[:admin_products_per_page])
  end

  def new
    @dynamic_datum = DynamicDatum.new

    respond_to do |format|
      format.html  # new.html.erb
      #format.json  { render :json => @dynamic_datum }
    end
  end

  def create
    @dynamic_datum = DynamicDatum.new(dynamic_datum_params)
    respond_to do |format|
      if @dynamic_datum.save

        format.html  { redirect_to(admin_dynamic_data_url,
                                   :notice => 'Dynamic Content was successfully created.') }
        #format.json  { render :json => @dynamic_datum,
        #	:status => :created, :location => @dynamic_datum }
      else
        format.html  { render :action => "new" }
        #format.json  { render :json => @dynamic_datum.errors,
        #	:status => :unprocessable_entity }
      end
    end
  end

  def edit
    @dynamic_datum = DynamicDatum.find(params[:id])

    respond_to do |format|
      format.html  # new.html.erb
    end
  end

  def update
    @dynamic_datum = DynamicDatum.find(params[:id])

    respond_to do |format|
      if @dynamic_datum.update_attributes(dynamic_datum_params)
        format.html  { redirect_to(admin_dynamic_data_url,
                                   :notice => 'DynamicDatum was successfully updated.') }
        #format.json  { head :no_content }
      else
        format.html  { render :action => "edit" }
        #format.json  { render :json => @dynamic_datum.errors,
        #	:status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @dynamic_datum = DynamicDatum.find(params[:id])

    respond_to do |format|
      if @dynamic_datum.destroy
        format.html { redirect_to admin_dynamic_data_url, :notice => "Dynamic Content was successfully deleted." }
      else
        format.html { redirect_to admin_dynamic_data_url, :error => "Dynamic Content was not deleted." }
      end
    end
  end

  private
  def dynamic_datum_params
    params.require(:dynamic_datum).permit(:id, :tag, :data)
  end
end
