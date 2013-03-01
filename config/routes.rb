RateProgrammerTools::Application.routes.draw do

	root :to => 'home#index'
	match 'home/search' => 'home#search'



	namespace :user do	
		#Activation
		get 'activate/:activation_token' => 'users#activate', as: :activate
		get 'resend_activation/:username' => 'users#resend_activation', as: :resend_activation

	  #Password Reset 
	  get  'forgot_password'  => 'reset_password#new'
	  post 'forgot_password'  => 'reset_password#create'
	  get  'reset_password/:reset_token' => 'reset_password#edit', as: :reset_password
	  put  'reset_password' =>  'reset_password#update', as: :update_password

		#Login, Signup routes
		get   'login'  => 'login#new'
		post  'login'  => 'login#create'
		match 'logout' => 'login#destroy'
	end
	#User related routes
	resource :user, only: [:new,:create,:update] do 
		collection do
			get '/' => 'users#index'
			get 'profile/:username' => 'users#show', as: :show
			get 'settings' => 'users#edit', as: :edit      

			#Alias to /user/new
			match  'signup' => 'users#new'
		end
	end




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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
