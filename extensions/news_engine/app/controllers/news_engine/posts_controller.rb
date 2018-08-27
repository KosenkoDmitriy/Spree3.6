class NewsEngine::PostsController < Spree::BaseController

	before_action do
		@selected_nav = :news
	end

	def posts
		@posts = Post.published.news.order("published_on DESC").page(params[:page]).per(12)
		self.title = "News"
		respond_to do |format|
			format.html {render :action => "posts"}
		end
	end

	def articles
		@posts = Post.published.articles.order("published_on DESC").page(params[:page]).per(12)
		self.title = "Articles"
		respond_to do |format|
			format.html {render :action => "articles"}
		end
	end

  def signup
    self.title="Sign Up For Our Newsletter Here"
    respond_to do |format|
      format.html {render :action => "signup"}
    end
  end

  def signup_thankyou
    self.title="Thanks for Signing Up"
    respond_to do |format|
      format.html {render :action => "signup_thankyou"}
    end
  end

  def unsubscribe
    self.title="Awww, really?"
    respond_to do |format|
      format.html {render :action => "unsubscribe"}
    end
  end

	def faqs
		@selected_nav = :about

		@posts = Post.published.faqs.order("published_on ASC")
		self.title = "Frequently asked questions"
		respond_to do |format|
			format.html { render :action => "faqs" }
		end
	end

	def show
		@post = Post.published.find_by_permalink params[:id]
    raise ActiveRecord::RecordNotFound if @post.nil?

		self.title = @post.title
		@selected_nav = :about if @post.faq?
		@selected_sub_nav = :faqs if @post.faq?

		respond_to do |format|
			format.html {
				if @post.faq?
					render :action => "faq"
				else
					render :action => "show"
				end
			}
		end
	end
end
