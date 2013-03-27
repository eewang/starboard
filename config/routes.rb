Starboard::Application.routes.draw do

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  root :to => 'users#index'

  post '/users/give_star/:id' => 'users#give_star', :as => 'give_star'

  resources :requirements

  resources :achievements

  resources :stars

  resources :users
  
  resources :sessions

end
