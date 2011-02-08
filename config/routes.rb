Castle::Application.routes.draw do
  
  resources :packages

  resources :cart_items

  resources :carts

  resources :orders

  resources :supports, :only => [:new, :create]
  resources :products
  resources :images
  resources :blogs
  resources :accounts
  resources :users
  resources :user_sessions
  resources :admins
  resources :admin_sessions
  
  # Login/Logout Paths
  match "account-login" => "user_sessions#check_session", :as => :account_login
  match "account-logout" => "user_sessions#destroy", :as => :account_logout
  
  # Admin Login/Logout Paths
  match "admin-login" => "admin_sessions#check_session", :as => :account_login
  match "admin-logout" => "admin_sessions#destroy", :as => :account_logout
  match "admin-dashboard" => "admins#admin_dashboard", :as => :admin_dashboard
  
  # Password Reset Path
  match "password-reset-submit" => "password_resets#create", :as => :password_submit_reset
  
  # Custom Routes
  match "about-castle-protection" => "pages#about", :as => :about
  match "contact-castle-protection" => "pages#contact", :as => :contact
  match "castle-privacy-policy" => "pages#privacy_policy", :as => :privacy
  match "castle-terms-of-service" => "pages#terms", :as  => :terms
  match "frequently-asked-questions" => "pages#faq", :as => :faq
  match "castle-return-policy" => "pages#return_policy", :as => :returns
  
  # Mailer Paths
  match "send-contact-email" => "supports#contact_email", :as => :contact_email
  
  root :to => "pages#index"

end
