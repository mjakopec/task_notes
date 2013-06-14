Infinum::Application.routes.draw do
  match 'user/edit' => 'users#edit', :as => :edit_current_user
  match 'signup' => 'users#new', :as => :signup
  match 'logout' => 'sessions#destroy', :as => :logout
  match 'login' => 'sessions#new', :as => :login
  match 'list' => 'tasks#index', :as => :list
  
  match 'order_list' => 'tasks#ordering_list', :as => :order_list
  
  resources :sessions
  resources :users
  resources :tasks
  
  root :to => "sessions#new"
end
