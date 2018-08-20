class TestimonialsEngine::TestimonialsController < Spree::BaseController
	include Spree::Core::ControllerHelpers::Order # for link_to_cart

	before_action do
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
