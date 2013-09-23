Sensoriumhealth::Application.routes.draw do
    # This add a working /users/1 URL
    # This endows the application with all the actions needed for a RESTful User resource, along with a large number of named routes for generating user URLs. Check out RESTful routes for all the routes available.
    resources :users

    # Resources method to define the standard RESTful routes.
    # No need to show or edit sessions, thus just restrict to new, create, and destroy using :only option.
    #
    # RESTful routes provided by sessions rules:
    # GET: page for a new session.
    # POST: create a new session.
    # DELETE: delete a session.
    resources :sessions, only: [:new, :create, :destroy]
    
    # route mapping for home page
    # this code maps the root URL / to /static_pages/home.
    # This means http://localhost:3000 is something other than defails rails page.
    # root_path -> '/'
    # root_url -> 'http://localhost:3000/'
    root 'static_pages#home'   
    
    # Custom named route for the signin and signout.
    match '/signup', to: 'users#new', via: 'get'
    match '/signin', to: 'sessions#new', via: 'get'
    # via: delete indicates signout should be invoked using HTTP DELETE request.
    match '/signout', to: 'sessions#destroy',   via: 'delete'



    # Code below matches at GET requests for '/about' and routes it to the about
    # action in the StaticPages controller.
    # The code: match '/about' automatically creates named routes for use
    # in the controllers and views:
    # about_path -> '/about'
    # about_url -> 'http://localhost:3000/about'
    match '/help',  to: 'static_pages#help',    via: 'get'
    match '/about',  to: 'static_pages#about',    via: 'get'
    match '/contact',  to: 'static_pages#contact',    via: 'get'
    
    # graphs page
    # match '/graphs' to: 'static_pages#graphs', via: 'get'

  resources :microposts
  
  resources :relaxation_sessions
    match '/home', to: 'relaxation_sessions#index', via: 'get'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
