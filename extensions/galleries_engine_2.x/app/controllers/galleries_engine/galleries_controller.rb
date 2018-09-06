class GalleriesEngine::GalleriesController < Spree::BaseController
	
	before_filter do
		@selected_nav = :gallery
	end

	def index
		@galleries = Gallery.enabled.order('category, created_at DESC')
		self.title = "Galleries"
	end
	
	def show
		@gallery = Gallery.enabled.find params[:id]
		self.title = @gallery.title
	end
	
end