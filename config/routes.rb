Castle::Application.routes.draw do

  # Admin Login/Logout Paths
  match "admin-login" => "admin_sessions#check_session", as: :admin_login
  match "admin-logout" => "admin_sessions#destroy", as: :admin_logout
  match "admin-dashboard" => "admins#admin_dashboard", as: :admin_dashboard

  # Admin Login/Logout Paths
  match "login" => "user_sessions#check_session", as: :login
  match "logout" => "user_sessions#destroy", as: :logout
  match "user-dashboard" => "users#show", as: :dashboard
  match "user-account" => "accounts#show", as: :user_account

  # Billing Information Paths
  match "update-user-billing-information" => "payment_info#update_billing_information", as: :update_billing_information
  match "update-user-creditcard-information" => "payment_info#update_credit_card_information", as: :update_credit_card_information
  match "update-user-information" => "payment_info#update_user_information", as: :update_user_information
  match "update-additional-account-information" => "payment_info#update_additional_information", as: :update_additional_information
  
  # Custom Routes
  match "about-castle-protection" => "pages#about", as: :about
  match "contact-castle-protection" => "pages#contact", as: :contact
  match "castle-privacy-policy" => "pages#privacy_policy", as: :privacy
  match "castle-terms-of-service" => "pages#terms", as:  :terms
  match "frequently-asked-questions" => "pages#faq", as: :faq
  match "castle-return-policy" => "pages#return_policy", as: :returns
  match "reassign-order-product" => "order_products#update", as: :reassign_order_product
  match "send-location-assignments" => "send_assigned_items#create", as: :send_location_assignments 
  match "update-location" => "order_products#ajax_update", as: :location_update
  
  # Mailer Paths
  match "send-product-locations-notification" => "notifications#send_product_locations", as: :send_product_locations
  match "send-contact-email" => "supports#contact_email", as: :contact_email
  match "send-user-contact-request" => "supports#user_dash_contact_request", as: :user_contact_request
  
  # Cart Paths
  match "add-item-to-cart(/:id)" => "products#add_items", as: :add_item
  match "remove-cart-item(/:id)" => "products#remove_items", as: :remove_item
  match "empty-cart" => "products#empty_cart", as: :empty_cart
  match "checkout" => "orders#new", as: :checkout
  match "purchase_add_ons" => "add_ons#create", as: :add_on_purchase

  resources :password_resets
  resources :additional_service_records
  resources :packages
  resources :add_ons
  resources :cart_items
  resources :carts
  resources :orders
  resources :order_products
  resources :user_interactive_products
  resources :user_dependent_products
  resources :send_assigned_items, only: [:new, :create]
  resources :supports, only: [:new, :create]
  resources :products
  resources :images
  resources :blogs
  resources :accounts
  resources :users
  resources :user_sessions
  resources :admins
  resources :admin_sessions
  
  root to: "pages#index"

end
