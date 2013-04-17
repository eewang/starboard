Starboard::Application.routes.draw do

  require 'sidekiq/web'

  get '/treehousechart' => 'groups#treehousechart'

  get '/users/remove_from_group/', to: 'users#remove_from_group'
  get '/users/make_teacher/', to: 'users#make_teacher'

  resources :groups
  # Group views
  ['stats', 'activity', 'combined', 'leaderboard', 'blog_posts', 'show'].each do |service|
    get "/groups/:id/#{ service }" => "groups##{ service }", :as => service
  end

  resources :users
  # User star views
  ['blog', 'codeschool', 'github', 'handraise', 'student', 'teacher', 'treehouse'].each do |service|
    get "/users/:id/#{ service }" => "users##{ service }", :as => service
  end

  mount Sidekiq::Web, at: '/sidekiq'

  get '/signup/:invitation_token', :controller => 'users', :action => 'new', as: 'join'


  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'


  get '/teachers/:id' => 'teachers#show', as: 'teacher_show'

  root :to => 'groups#index'

  post '/users/give_star/:id' => 'users#give_star', :as => 'give_star'

  post '/users/teacher_star/:id' => 'users#create_teacher_star', :as => 'teacher_star'

  get '/achievements/newest.json' => 'groups#get_recent_achievements'

  resources :achievements

  # get '/signup', :controller => 'users', :action => 'new'
  # get 'teacher/signup', to: 'teachers#new', as: 'teacher_signup'
  # post 'teacher/signup', to: 'teachers#create', as: 'teacher_signup'
  # post 'handraise', to: 'handraise#create'
  # resources :stars
  
  resources :sessions

  resources :invitations

  # resources :group_users
  
  get '/login/join/:invitation_token', to: 'group_users#login', as: 'group_login'

  get '/group/join/:invitation_token', to: 'group_users#new', as: 'group_signup'

  # refill star bank
  get '/refill_star_bank', to: 'users#refill_star_bank', as: 'refill_star_bank'
  post '/refill_star_bank', to: 'users#refill_star_bank_create', as: 'refill_star_bank_create'

end
