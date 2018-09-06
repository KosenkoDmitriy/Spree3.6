class GalleriesEngine::Admin::GalleriesController < Spree::Admin::BaseController

	def index
		@galleries = Gallery.
        order('enabled DESC').
			  page(params[:page]).
			  per(Spree::Config[:admin_products_per_page])
	end

	def show
		@gallery = Gallery.find params[:id]
		respond_to do |format|
		    format.html
		end
	end

	def new
		@gallery = Gallery.new
		@categories = Gallery.category_list
		respond_to do |format|
		    format.html
		end
	end

	def create
		@gallery = Gallery.new(params[:gallery])
		respond_to do |format|
			if @gallery.save
				format.html  { redirect_to(admin_galleries_url,
					:notice => 'Gallery was successfully created.') }
			else
				format.html  { render :action => "new" }
			end
  		end
	end

	def edit
		@gallery = Gallery.find(params[:id])
    @categories = Gallery.category_list
		respond_to do |format|
		    format.html
		end
  end

	def update
		@gallery = Gallery.find(params[:id])
		respond_to do |format|
			if @gallery.update_attributes(params[:gallery])
				format.html  { redirect_to(admin_galleries_url,
					:notice => 'Gallery was successfully updated.') }
			else
				format.html  { render :action => "edit" }
			end
		end
	end

	def destroy
		@gallery = Gallery.find(params[:id])
		respond_to do |format|
			if @gallery.destroy
				format.html { redirect_to admin_galleries_url, :notice => "Gallery was successfully deleted." }
			else
				format.html { redirect_to admin_gallery_url(@gallery), :error => "Gallery was not deleted." }
			end
		end
	end
	
end