class GalleriesEngine::PhotosController < Spree::BaseController
	
	before_filter :find_gallery
	before_filter do
		@selected_nav = :gallery
	end
	
	def index
		@photos = @gallery.photos
	end
	
	def  show
		@photo = @gallery.photos.find params[:id]
		
		idx = @gallery.photos.index(@photo)
		@next_photo = @gallery.photos[idx+1]
		@previous_photo = @gallery.photos[idx-1] unless idx-1 < 0
	end
	
	protected
	
	def find_gallery
		unless @gallery = Gallery.find(params[:gallery_id])
			redirect_to galleries_url
		end
	end
	
end