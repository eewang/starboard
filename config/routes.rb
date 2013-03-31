Starboard::Application.routes.draw do

  resources :groups


  resources :invitations

  get '/signup/:invitation_token', :controller => 'users', :action => 'new', as: 'join'

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  post 'handraise', to: 'handraise#create'

  root :to => 'users#index'

  post '/users/give_star/:id' => 'users#give_star', :as => 'give_star'

  post '/users/refill_star_bank/:id' => 'users#refill_star_bank', :as => 'refill_star_bank'

  post '/users/teacher_star/:id' => 'users#create_teacher_star', :as => 'teacher_star'

  get '/achievements/newest/:id' => 'achievements#get_recent_achievements'

  resources :requirements

  resources :stars

  resources :users
  
  resources :sessions

  resources :group_users

  get '/group/join', to: 'group_users#new', as: 'join'

end
