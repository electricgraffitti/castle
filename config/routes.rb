Castle::Application.routes.draw do

  resources :user_dependent_products

  # Admin Login/Logout Paths
  match "admin-login" => "admin_sessions#check_session", :as => :admin_login
  match "admin-logout" => "admin_sessions#destroy", :as => :admin_logout
  match "admin-dashboard" => "admins#admin_dashboard", :as => :admin_dashboard

  # Admin Login/Logout Paths
  match "login" => "user_sessions#check_session", :as => :login
  match "logout" => "user_sessions#destroy", :as => :logout
  match "user-dashboard" => "users#show", :as => :dashboard
  
  # Password Reset Path
  match "password-reset-submit" => "password_resets#create", :as => :password_submit_reset
  
  # Custom Routes
  match "about-castle-protection" => "pages#about", :as => :about
  match "contact-castle-protection" => "pages#contact", :as => :contact
  match "castle-privacy-policy" => "pages#privacy_policy", :as => :privacy
  match "castle-terms-of-service" => "pages#terms", :as  => :terms
  match "frequently-asked-questions" => "pages#faq", :as => :faq
  match "castle-return-policy" => "pages#return_policy", :as => :returns
  match "reassign-order-product" => "order_products#update", :as => :reassign_order_product
  
  # Mailer Paths
  match "send-assigned-item-notification" => "notifications#send_assigned_items", :as => :send_assigned_items
  match "send-contact-email" => "supports#contact_email", :as => :contact_email
  
  # Cart Paths
  match "add-item-to-cart(/:id)" => "products#add_items", :as => :add_item
  match "remove-cart-item(/:id)" => "products#remove_items", :as => :remove_item
  match "empty-cart" => "products#empty_cart", :as => :empty_cart
  match "checkout" => "orders#new", :as => :checkout
  match "purchase_add_ons" => "add_ons#create", :as => :add_on_purchase

  resources :packages
  resources :add_ons
  resources :cart_items
  resources :carts
  resources :orders
  resources :order_products
  resources :supports, :only => [:new, :create]
  resources :products
  resources :images
  resources :blogs
  resources :accounts
  resources :users
  resources :user_sessions
  resources :admins
  resources :admin_sessions
  
  root :to => "pages#index"

end
