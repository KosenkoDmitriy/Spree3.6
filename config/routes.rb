Rails.application.routes.draw do
  get '/404' => 'errors#error_404'
  get '/422' => 'errors#error_422'
  get '/500' => 'errors#error_500'

  match 'about' => 'base#about', :as => "about", via: [:get]
  match 'links' => 'base#links', via: [:get]
  match 'events' => 'base#events', via: [:get]
  match 'shop' => 'base#shop', :as => "shop", via: [:get]

  # Footer Nav Extras
  match "terms" => 'base#terms', via: [:get]
  match "terms_and_conditions_b2b" => 'base#terms_and_conditions_b2b', via: [:get]
  match "gift_voucher_terms" => 'base#gift_voucher_terms', via: [:get]
  match "competition_terms" => 'base#competition_terms', via: [:get]
  match "privacy_policy" => 'base#privacy_policy', via: [:get]
  #match "faqs" => 'base#faqs' # Overriden by news section
  match "warranty" => 'base#warranty', via: [:get]
  match "shipping" => 'base#shipping', via: [:get]
  match "contact" => 'base#contact', via: [:get]
  match "returns" => 'base#returns_policy', via: [:get]
  match "projects" => 'base#projects', via: [:get]
  match "schedule" => redirect("/"), via: [:get]
  match "rentals" => 'base#rentals', via: [:get]
  match "leave_no_trace" => 'base#leave_no_trace', via: [:get]

  match "press" => 'base#press', via: [:get]
  match "videos" => 'base#videos', via: [:get]
  match "cookie_policy" => 'base#cookie_policy', via: [:get]

  match "/products/:id/images/:image_id" => "products#image", via: [:get]

  get '/products', :to => 'spree/products#index', via: [:get]
  get '/sale', :to => "spree/products#sale", :as => :sale, via: [:get]
  get '/invoice/:id' => 'spree/orders#invoice', :as => :invoice, via: [:get]

  root :to => 'base#index'

  mount DynamicContentManagementEngine::Engine, at: '/'
  mount TestimonialsEngine::Engine, at: '/'
  mount FeaturesEngine::Engine, at: '/';

  # mount GalleriesEngine::Engine, :at => "/"
  # mount NewsEngine::Engine, :at => "/"
  # mount AffiliateEngine::Engine, :at => "/"

  # mount Spree::Core::Engine, at: '/spree', as: :spree
  mount Spree::Core::Engine, at: '/', as: :spree

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
