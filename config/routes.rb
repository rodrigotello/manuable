Manuable::Application.routes.draw do
  # match "/404", :to => "errors#not_found"
  # match "/500", :to => "errors#app_failure"
  root :to => 'home#index'

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  get "home/index"
  get "/mercadosemilla", to: "events#show", id: 6
  get "/octapus", to: "events#show", id: 5
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

  resources :event_payments do
    post :oxxo_payment, on: :member
    post :oxxo_success, on: :collection
    get :oxxo_success, on: :collection
  end

  resources :event_requests, only: [:update, :destroy]

  resources :events do
    get :map, on: :member
    get :checkout, on: :member
    post :checkout, on: :member
    get :request_access, on: :member
    post :request_access, on: :member
    resources :event_schedules
    resources :event_schedule_categories
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
  get "/:id", to: "users#show"
end
