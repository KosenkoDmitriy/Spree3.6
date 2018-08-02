FeaturesEngine::Engine.routes.draw do
  # Add your extension routes here

  namespace :admin do
    resources :features
  end
end