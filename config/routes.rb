ActionController::Routing::Routes.draw do |map|
  devise_for :users
  resources :accounts do
    member do
      get :refresh
    end
  end
  resources :marketplace_posts
  resources :pages
  resources :contacts do
    member do
      get :invite
    end
  end
  resources :events
  resource :search
  resources :news_posts do
    collection do
      get :tags
    end
  end
  match '/dashboard' => "website#dashboard", :as => "dashboard"
  match '/news' => "website#news", :as => "news"
  map.calendar '/calendar/:year/:month', :controller => 'calendar', :action => 'index', :requirements => {:year => /\d{4}/, :month => /\d{1,2}/}, :year => nil, :month => nil
  match '/:id' => "website#page", :as => "webpage" # Just above root
  root :to => "website#index"
end
