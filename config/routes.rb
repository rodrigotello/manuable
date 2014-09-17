Manuable::Application.routes.draw do

  get "order_address/new"
  get "order_address/save"
  get "order_address/delete"
  get "order_address/update"
  get "order_items/new"
  get "order_items/save"
  get "order_items/delete"
  get "orders/new"
  get "orders/save"
  get "orders/delete"
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  # match "/404", :to => "errors#not_found"
  # match "/500", :to => "errors#app_failure"
  root :to => 'home#index'
  mount Commontator::Engine => '/commontator'

  get "home/index"
  # get "/mercadosemilla", to: "events#show", id: 6
  # get "/octapus", to: "events#show", id: 5
  get "about", to: "home#about"

  # match 'product/:id' => 'home#product'

  devise_for :user, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  # get '/users/auth/:provider/' => 'omniauth_callbacks#passthru'

  resources :users, only: [:show, :index] do
    post '/follow', on: :member, to: 'followings#create'
    delete '/unfollow', on: :member, to: 'followings#destroy'
    resources :products, only: [:index, :show]
    resources :events, only: :index
  end

  resources :products do
    post :like, on: :member
    resources :attachments
  end

  resources :carts 
  resources :premium_user_datum

  resources :event_payments do
    post :oxxo_payment, on: :member
    post :oxxo_success, on: :collection
    get :oxxo_success, on: :collection
  end

  resources :events do
    get :webhook, on: :collection
    post :webhook, on: :collection
    get :map, on: :member
    get :checkout, on: :member
    get :publish, on: :member
    post :publish, on: :member
    post :checkout, on: :member
    get :request_access, on: :member
    post :request_access, on: :member
    resources :event_schedules
    resources :event_schedule_categories
    resources :event_requests, path: :requests
  end

  resources :event_schedule_categories do
    resources :event_schedules
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


  scope defaults: { :format => :json }, :except => [:edit, :new] do
    namespace :api do
      match '*path',
            controller: 'application',
            action: 'options_for_mopd',
            via: :options
      namespace :my do
        resource :profile, except: [:create, :destroy]
        resources :products
      end
      resource :authentications, only: :create
      resources :categories
      resources :events
      resources :users, only: [:show, :index] do
        resources :messages
        resources :conversations
        post :follow, on: :member, controller: :followings, action: :create
        delete :follow, on: :member, controller: :followings, action: :destroy
        resources :products, shallow: true do
          post :likes, on: :member
        end
      end
      resources :products, only: :index

      match "*path", to: "application#routing_error", via: [:get, :post, :put, :delete, :patch]
    end

  end

  get "/:id", to: "landing#index"
end
