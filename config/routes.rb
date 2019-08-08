Rails.application.routes.draw do
  get "/create_book", to: "books#new"
  post "/create_book", to: "books#create"

  get "/create_author", to: "authors#new"
  post "/create_author", to: "authors#create"
  
  get "/create_publisher", to: "publishers#new"
  post "/create_publisher", to: "publishers#create"
  
  get "/create_category",to: "categories#new"
  post "/create_category",to: "categories#create"
  
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  
  get "/about", to: "static_pages#about"
  
  root "static_pages#home"
  resources :users
  resources :categories
  resources :publishers
  resources :authors
  resources :books
end
