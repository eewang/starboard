Starboard::Application.routes.draw do

  require 'sidekiq/web'

  resources :groups
  # Group views
  ['stats', 'activity', 'combined', 'leaderboard'].each do |service|
    get "/groups/:id/#{ service }" => "groups##{ service }", :as => service
  end

  resources :users
  # User star views
  ['blog', 'codeschool', 'github', 'handraise', 'student', 'teacher', 'treehouse'].each do |service|
    get "/users/:id/#{ service }" => "users##{ service }", :as => service
  end

  get '/signup', :controller => 'users', :action => 'new'


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

  resources :achievements

  resources :stars
  
  resources :sessions


  resources :group_users
  
  get '/login/join/:invitation_token', to: 'group_users#login', as: 'group_login'

  get '/group/join/:invitation_token', to: 'group_users#new', as: 'group_signup'


end
