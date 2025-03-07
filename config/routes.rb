Rails.application.routes.draw do
  resources :microposts, only: [ :create, :destroy ]
  # resources :users, only: [:index, :show, :new, :create, :edit, :update]
  resources :account_activations, only: [ :edit ]
  resources :password_resets, only: [ :new, :create, :edit, :update ]
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [ :create, :destroy ]

  get "static_pages/home", as: :home
  get "static_pages/help", to: "static_pages#help", as: :help
  get 'static_pages/about', to: 'static_pages#about', as: :about
  get 'static_pages/contact', to: "static_pages#contact", as: :contact
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  root 'static_pages#home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
