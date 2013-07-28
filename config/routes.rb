Manuable::Application.routes.draw do
  match "/404", :to => "errors#not_found"
  match "/500", :to => "errors#app_failure"
  root :to => 'home#index'

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  get "home/index"
  get "about", to: "home#about"

  # match 'product/:id' => 'home#product'

  devise_for :user, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  # get '/users/auth/:provider/' => 'omniauth_callbacks#passthru'

  resources :users, only: [:show, :index] do
    resources :followings, only: :create
    resources :products, only: [:index, :show]
  end

  resources :products do
    post :like, on: :member
    resources :attachments
  end

  resources :event_payments
  resources :event_requests, only: [:update, :destroy]

  resources :events do
    get :checkout, on: :member
    post :checkout, on: :member
    get :request_access, on: :member
    post :request_access, on: :member
  end
#  resources :categories do
#    resources :categories
#  end

  namespace :my do
    resource :profile, except: :create
    resources :conversations do
      resources :messages
    end
    resources :products do
      resources :attachments
    end
    resources :notifications, only: [:show, :update]
  end

  resources :categories, only: [:show, :index]
  resources :cities, only: [:index]

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
  # match '/(:id)', controller: :users, action: :show

end
