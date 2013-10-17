Crossword::Application.routes.draw do
  root :to => 'words#index'

  resources :words

  get '/photos', to: 'photos#index'

  get '/word_urls', to: 'words#show'

end
