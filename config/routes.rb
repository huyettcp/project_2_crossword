Crossword::Application.routes.draw do
  root :to => 'words#index'

  resources :words

  get '/photos', to: 'photos#index'

end
