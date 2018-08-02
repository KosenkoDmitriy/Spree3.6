DynamicContentManagementEngine::Engine.routes.draw do
  # Add your extension routes here
	namespace :admin do
		resources :dynamic_data
		get "dynamic_data/picker_gallery/:gallery_id" => "posts#picker_gallery"
	end
end
