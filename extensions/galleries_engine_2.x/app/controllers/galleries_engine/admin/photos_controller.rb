class GalleriesEngine::Admin::PhotosController < Spree::Admin::BaseController

	before_filter :find_gallery

	def index
		@photos = @gallery.photos
			page(params[:page]).
			per(Spree::Config[:admin_products_per_page])
			
	end

	def show
		@photo = @gallery.photos.find params[:id]
		respond_to do |format|
		    format.html
		end
	end

	def new
		@photo = @gallery.photos.new

		respond_to do |format|
		    format.html  # new.html.erb
		    #format.json  { render :json => @photo }
		end
	end
	def create
		@photo = @gallery.photos.new(params[:photo])
 
		respond_to do |format|
			if @photo.save
				format.html  { redirect_to(admin_gallery_url(@gallery),
					:notice => "#{@photo.caption} was successfully created.") }
				#format.json  { render :json => @photo,
				#	:status => :created, :location => @photo }
			else
				format.html  { render :action => "new" }
				#format.json  { render :json => @photo.errors,
				#	:status => :unprocessable_entity }
			end
  		end
	end

	def edit
		@photo = @gallery.photos.find(params[:id])

		respond_to do |format|
		    format.html  # new.html.erb
		end
	end
	def update
		@photo = @gallery.photos.find(params[:id])

		respond_to do |format|
			if @photo.update_attributes(params[:photo])
				format.html  { redirect_to(admin_gallery_url(@gallery),
					:notice => "#{@photo.caption} was successfully updated.") }
				#format.json  { head :no_content }
			else
				format.html  { render :action => "edit" }
				#format.json  { render :json => @photo.errors,
				#	:status => :unprocessable_entity }
			end
		end
	end

	def destroy
		@photo = @gallery.photos.find(params[:id])

		respond_to do |format|
			if @photo.destroy
				format.html { redirect_to admin_gallery_url(@gallery), :notice => "#{@photo.caption} was successfully deleted." }
			else
				format.html { redirect_to admin_gallery_photo_url(@gallery, @photo), :error => "#{@photo.caption} was not deleted." }
			end
		end
	end
	

	protected

	def find_gallery
		@gallery= Gallery.find(params[:gallery_id])
	end
	
end