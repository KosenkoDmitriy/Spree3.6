class TestimonialsEngine::TestimonialsController < Spree::BaseController

	before_filter do
		@selected_nav = :about
	end
	
	def index
		@testimonials = Testimonial.enabled.order("created_at DESC").page(params[:page]).per(10)
		self.title = "Testimonials"
		respond_to do |format|
			format.html
		end
	end
	
end
