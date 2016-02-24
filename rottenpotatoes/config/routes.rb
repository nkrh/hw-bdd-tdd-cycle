Rottenpotatoes::Application.routes.draw do
  
  resources :movies
  # map '/' to be a redirect to '/movies'
  root 'movies#index'
  match '/movie(/:id(/search_directors))', via: [:get, :post], :to => 'movies#search_directors', as: 'search_directors'
end