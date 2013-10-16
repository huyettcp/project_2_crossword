Crossword::Application.routes.draw do
  root :to => 'words#index'

  resources :words

  get '/photos', to: 'photos#index'

  post '/users', to: 'users#create'

  post '/scores', to: "scores#create"

end
