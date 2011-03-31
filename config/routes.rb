OpenSourceOfficeHours::Application.routes.draw do
  get "courses/index"

  get "courses/create"

  get "courses/new"

  get "courses/edit"

  get "courses/show"

  get "courses/update"

  get "courses/destroy"

  get "index/create"

  get "index/new"

  get "index/edit"

  get "index/show"

  get "index/update"

  get "index/destroy"

  get "officehour/index"

  get "officehour/show"

  get "index/index"

  get "index/about"

  # registration
  match "/register" => "account#new", :as => :register
  match "/activate/:activation_code" => "account#activate", :activation_code => nil, :as => :user_activate
  
  match "/officehour/show/:id" => "officehour#show"
  match "/officehour" => "officehour#index"
  
  # sessions control
  resources :session
  get "/login" => "session#new", :as => :login
  post "/login" => "session#create"
  match "/logout" => "session#destroy", :as => :logout
  
  
  # account
  resources :account, :as => :users do
    get 'password', :on => :member
  end
  
  resources :courses, :as => :user_courses
  match "/courses/numbers/:department" => "courses#numbers"
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"
  root :to => "index#index"
  match 'about' => "index#about"
  

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
