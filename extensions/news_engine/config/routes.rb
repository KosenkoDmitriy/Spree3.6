NewsEngine::Engine.routes.draw do
  # Add your extension routes here

	match "/news" => "posts#posts", :as => :posts, via: [:get]
	match "/news/:id" => "posts#show", :as => :post, via: [:get]
	match "/articles" => "posts#articles", :as => :articles, via: [:get]
	match "/articles/:id" => "posts#show", :as => :article, via: [:get]

	match "/faqs" => "posts#faqs", :as => :faqs, via: [:get]
	match "/faqs/:id" => "posts#show", :as => :faq, via: [:get]

	#newsletter links
	match "/newsletter/signup" => "posts#signup", :as => :newsletter_signup, via: [:get]
	match "/newsletter/thankyou" => "posts#signup_thankyou", :as => :newsletter_thank_you, via: [:get]
	match "/newsletter/unsubscribe" => "posts#unsubscribe", :as => :newsletter_unsubscribe, via: [:get]

	#resources :news, :controller => "posts", :only => [:index, :show]
	#resources :articles, :controller => "posts", :only => [:index, :show]

	namespace :admin do
		resources :posts do
		  put "unpublish", :on => :member
	  end
		match "posts/picker_gallery/:gallery_id" => "posts#picker_gallery", via: [:get]
	end
end
