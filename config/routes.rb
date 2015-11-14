Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  root to: "videos#index"

  get '/home', to: "videos#index"
  #get '/videos/:id',  to: "videos#show", as: "video" #delete this later and use resources?
  resources :videos, only: [:show] do
  	collection do
  		get :search, to: "videos#search"
    end
  end
  #resources :videos
  #get '/videos/search', to: "videos#search", as: "search_videos_path"
  get '/categories/:id', to: "categories#show", as: "category" #delete later and use resources?
end
