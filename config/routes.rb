Starboard::Application.routes.draw do

  require 'sidekiq/web'

  resources :groups

  mount Sidekiq::Web, at: '/sidekiq'


  resources :invitations

  get '/signup/:invitation_token', :controller => 'users', :action => 'new', as: 'join'
  get '/groups/:id', to: 'groups#show'

  get 'teacher/signup', to: 'teachers#new', as: 'teacher_signup'
  post 'teacher/signup', to: 'teachers#create', as: 'teacher_signup'

  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  post 'handraise', to: 'handraise#create'

  get '/teachers/:id' => 'teachers#show', as: 'teacher_show'

  root :to => 'groups#index'

  post '/users/give_star/:id' => 'users#give_star', :as => 'give_star'

  post '/users/refill_star_bank/:id' => 'users#refill_star_bank', :as => 'refill_star_bank'

  post '/users/teacher_star/:id' => 'users#create_teacher_star', :as => 'teacher_star'

  get '/achievements/newest.json' => 'groups#get_recent_achievements'

  resources :requirements

  resources :stars
  
  resources :sessions

  resources :users

  resources :group_users

  get '/group/join', to: 'group_users#new', as: 'groupsignup'

end
