Rails.application.routes.draw do
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  get 'about', to: 'static_pages#about'
  
  root 'static_pages#home'
  resources :users
end
