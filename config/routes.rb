ActionController::Routing::Routes.draw do |map|

  map.resources :movie_visits
  map.new_movie_visit_for_movie 'movies/:movie/movie_visit/new', :controller => :movie_visits, :action => :new

  map.resources :favourite_cinemas, :only => [:index, :create, :destroy]

  map.signup 'signup', :controller => 'users', :action => 'new'
  map.logout 'logout', :controller => 'sessions', :action => 'destroy'
  map.login 'login', :controller => 'sessions', :action => 'new'
  map.resources :sessions

  map.resources :users

  map.movie_shows 'movies/:id/:date', :controller => :movies, :action => :show, :date => 'today',
                  :requirements => { :id =>/\d+/}
  map.movies_premieres 'movies/premieres/:order', :controller => :movies, :action => :index, :order => 'by_screens', :premieres => true
  map.movies_premieres 'movies/3d/:order', :controller => :movies, :action => :index, :order => 'by_screens', :in_3d => true
  map.movies 'movies/:order', :controller => :movies, :action => :index, :order => 'by_screens'

  map.resources :movies, :only => [:show]
  map.resources :cinemas


  map.root :controller => :movies

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
