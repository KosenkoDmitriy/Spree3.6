AffiliateEngine::Engine.routes.draw do

  namespace :admin do
    resources :offers
  end

  resources :offers, :only => [:index, :show]
end
