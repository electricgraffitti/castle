Castle::Application.routes.draw do
  
  resources :accounts
  resources :users
  resources :user_sessions
  
  # Login/Logout Paths
  match "account-login" => "user_sessions#check_session", :as => :account_login
  match "account-logout" => "user_sessions#destroy", :as => :account_logout
  
  # Password Reset Path
  match "password-reset-submit" => "password_resets#create", :as => :password_submit_reset
    

  root :to => "pages#index"

end
