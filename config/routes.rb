SensoriumhealthDevise::Application.routes.draw do
  
  
  devise_for :admins
  resources :admin
  match '/', to: 'static_pages#home', via: 'get'
  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  match '/terms',   to: 'static_pages#terms',   via: 'get'
  match '/privacy', to: 'static_pages#privacy', via: 'get'
  match '/leaderboard', to: 'user#leaderboard', via: 'get'

  match '/send_email', to: 'emailer#contact', via: 'get'
  match '/dispatch_email', to: 'emailer#dispatch_email', as: "dispatch_email", via: 'post'

  match '/parse_xml', to: 'admin#parse_xml', via:'get'
  match '/relaxation_session', to: 'user#show_relaxation_session', via:'get'


    # Where to redirect user upon login
    #authenticated :user do
    #root :to => 'user#show'
    #end

    root :to => 'static_pages#home'
    devise_for :users
    resources :user

    resources :relaxation_sessions
      match '/graph', to: 'ibi#index', via:'get'



end
