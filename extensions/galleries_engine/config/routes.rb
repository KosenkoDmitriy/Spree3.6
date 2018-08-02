GalleriesEngine::Engine.routes.draw do
  # Add your extension routes here

	resources :galleries, :only => [:index, :show] do 
		resources :photos, :only => [:show]
	end
	namespace :admin do
		resources :galleries do
			resources :photos
		end
	end

end
