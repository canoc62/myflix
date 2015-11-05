Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  root to: "videos#index"

  get '/home', to: "videos#index"
  get '/videos/:id',  to: "videos#show", as: "video" #delete this later and use resources?
  #resources :videos
  get '/categories/:id', to: "categories#show", as: "category" #delete later and use resources?
end
