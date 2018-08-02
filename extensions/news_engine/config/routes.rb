NewsEngine::Engine.routes.draw do
  # Add your extension routes here
	
	match "/news" => "posts#posts", :as => :posts
	match "/news/:id" => "posts#show", :as => :post
	match "/articles" => "posts#articles", :as => :articles
	match "/articles/:id" => "posts#show", :as => :article
	
	match "/faqs" => "posts#faqs", :as => :faqs
	match "/faqs/:id" => "posts#show", :as => :faq
	
	#newsletter links
	match "/newsletter/signup" => "posts#signup", :as => :newsletter_signup
	match "/newsletter/thankyou" => "posts#signup_thankyou", :as => :newsletter_thank_you
	match "/newsletter/unsubscribe" => "posts#unsubscribe", :as => :newsletter_unsubscribe
  
	#resources :news, :controller => "posts", :only => [:index, :show]
	#resources :articles, :controller => "posts", :only => [:index, :show]
	
	namespace :admin do
		resources :posts do
		  put "unpublish", :on => :member
	  end
		match "posts/picker_gallery/:gallery_id" => "posts#picker_gallery"
	end
end
