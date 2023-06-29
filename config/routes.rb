Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  # get 'users/new'
  # GET / => static_pages#home
  root   "static_pages#home"
  # root "hello#index"

  # GET /static_pages/home => static_pages#home
  # get 'static_pages/home'
  # get 'static_pages/help'
  # get 'static_pages/about'
  # get 'static_pages/contact'
  get    "/help",       to: "static_pages#help"
  get    "/about",      to: "static_pages#about"
  get    "/contact",    to: "static_pages#contact"
  get    "/signup",     to: "users#new"
  get    "/login",      to: "sessions#new"
  post   "/login",      to: "sessions#create"
  delete "/logout",     to: "sessions#destroy" 

  resources :users
  # => get "/users",     to: "users#index"
  # => get "/users/:id", to: "users#show"
  # => get "/users/new", to: "users#new"
  # ...

  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
  get '/microposts', to: 'static_pages#home'

end
