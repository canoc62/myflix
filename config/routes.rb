Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  root to: "pages#front"

  get '/home', to: "videos#index"

  get '/register', to: "users#new"

  get '/my_queue', to: "queue_items#index"
  post '/my_queue', to: "queue_items#post"

  resources :queue_items, only: [:create, :destroy]

  resources :users, only: [:create]

  get '/sign_in', to: "sessions#new"

  resources :sessions, only: [:create]
  
  get '/sign_out', to: "sessions#destroy"
 
  resources :videos, only: [:show] do
  	collection do
  		get :search, to: "videos#search"
    end
    resources :reviews, only: [:create]
  end

  get '/categories/:id', to: "categories#show", as: "category" 
end
