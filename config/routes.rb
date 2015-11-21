Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  root to: "pages#front"

  get '/home', to: "videos#index"
  get '/register', to: "users#new"#, as: "register"
  resources :users, only: [:create]
  get '/sign_in', to: "sessions#new"
  resources :sessions, only: [:create]
  #post '/sign_in', to: "sessions#create"
  get '/sign_out', to: "sessions#destroy"
  #get '/videos/:id',  to: "videos#show", as: "video" #delete this later and use resources?
  resources :videos, only: [:show] do
  	collection do
  		get :search, to: "videos#search"
    end
    resources :reviews, only: [:create]
  end
  #resources :videos
  #get '/videos/search', to: "videos#search", as: "search_videos_path"
  get '/categories/:id', to: "categories#show", as: "category" #delete later and use resources?
end
