class BaseController < Spree::BaseController
	include Spree::Core::ControllerHelpers::Order # for link_to_cart

	helper "spree/products"

	def index
		self.title = "Welcome"
		# @features = Feature.enabled.sort_by{rand}
		# @testimonial = Testimonial.find(:first, :order => "RAND()")
		# @posts = Post.news.published.limit(I18n.t(:no_of_posts_on_index)).order("posts.published_on DESC")
    respond_to do |format|
      format.html
      format.xml { render :xml => "<welcome>Welcome to Soulpad</welcome>"}
    end
	end

	def about
		self.title = "About"
		@selected_nav = :about
	end

	def projects
		self.title = "Your Projects"
		@selected_nav = :projects
	end

	def offers
		uk_only!
		self.title = "Offers"
		@selected_nav = :about
	end

	def links
		self.title = "Links"
		@selected_nav = :about
	end

	def events
		uk_only!
		self.title = "Events"
		@selected_nav = :events
	end

	def rentals
		self.title = "SoulPad Hire"
		@selected_nav = :about
	end

	def terms
		self.title = "Terms and Conditions"
	end
	def gift_voucher_terms
		self.title = "Gift Voucher Terms and Conditions"
	end
	def competition_terms
		self.title = "Competition Terms and Conditions"
	end

	def leave_no_trace
		self.title = "Leave No Trace"
		@selected_nav = :about
	end

	def privacy_policy
		self.title = "Privacy Policy"
	end

	def schedule
		self.title = "Our Schedule"
		@selected_nav = :about
	end

	def faqs
	  self.title = "Frequently asked questions"
	  @selected_nav = :about
	end

	def warranty
		self.title = "Warranty"
	end

	def shipping
		self.title = "Shipping"
	end

	def contact
		self.title = "Contact Us"
		@selected_nav = :contact
		return unless request.post?
		return unless params[:email_address] && params[:message_subject] && params[:message] and !params[:message].first.empty?
		NotifierMailer.contact_email(params).deliver if params[:content].empty?
		flash.now[:notice] = "Thanks for getting in contact, we'll get back to you as soon as we can"
	end

	def returns_policy
		self.title = "Returns Policy"
	end

	def press
		self.title = "Press"
		@selected_nav = :about
	end

	def videos
		self.title = "Videos"
		@selected_nav = :about
	end

    def showroom
		uk_only!
		self.title = "Showroom"
		@selected_nav = :about
    end

	def cookie_policy
		self.title = "Cookie Policy"
	end

	def shop
		self.title = "Shop"
		@selected_nav = :shop
		@features = Feature.shop_main.sort_by{rand}
		@small_left_feature = Feature.shop_small_left.sort_by{rand}.first
		@small_right_feature = Feature.shop_small_right.sort_by{rand}.first
	end

	def terms_and_conditions_b2b
		self.title = "Terms and Conditions B2B"
	end

	private

	def uk_only!
		raise ActionController::RoutingError.new('Not Found') unless I18n.locale.to_s == 'en-GB'
	end
end
