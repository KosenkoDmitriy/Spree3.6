TestimonialsEngine::Engine.routes.draw do
  # Add your extension routes here
	
	namespace :admin do
		resources :testimonials
	end
	resources :testimonials, :only => [:index]
end
