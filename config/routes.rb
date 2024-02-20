Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  resources :products
  resources :users

  post "/auth/login", to: "authentication#login"

  resources :passwords, only: [:update]

  resources :password_resets, only: [:edit, :update]


  resources :password_resets do
   get :show_error, on: :collection
   get :edit_error, on: :collection
  end

    # resources :carts

  post "/add_product/:id", to: "carts#add_product"

  delete "/remove_product/:id", to: "carts#remove_product"
  get "/my_cart",  to: "carts#view_cart"

  #  addresses

  resources :addresses

  resources :orders

# stripe payment

  # post "/payments", to: "payments#create"
   post "/payments/checkout", to: "payments#checkout"
   get  "/payments/retrive_checkout", to: "payments#retrive_checkout"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
