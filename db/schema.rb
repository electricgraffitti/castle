# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130217220927) do

  create_table "accounts", :force => true do |t|
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "additional_service_records", :force => true do |t|
    t.integer  "user_id"
    t.string   "cross_street"
    t.text     "permit_info"
    t.string   "secondary_phone"
    t.string   "subdivision"
    t.string   "emergency_name"
    t.string   "emergency_password"
    t.string   "secondary_address"
    t.string   "secondary_city"
    t.integer  "state_id"
    t.string   "secondary_zip"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "admin_sessions", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admins", :force => true do |t|
    t.string   "username"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "single_access_token"
    t.string   "perishable_token"
    t.integer  "login_count"
    t.integer  "failed_login_count"
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "billing_records", :force => true do |t|
    t.integer  "user_id"
    t.integer  "order_id"
    t.string   "city"
    t.string   "address"
    t.string   "billing_zip"
    t.integer  "state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "billing_records", ["user_id"], :name => "index_billing_records_on_user_id"

  create_table "blogs", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cart_items", :force => true do |t|
    t.integer  "product_id"
    t.integer  "cart_id"
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "package_id"
  end

  add_index "cart_items", ["cart_id"], :name => "index_cart_items_on_cart_id"
  add_index "cart_items", ["package_id"], :name => "index_cart_items_on_package_id"
  add_index "cart_items", ["product_id"], :name => "index_cart_items_on_product_id"

  create_table "carts", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "complete"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "package_id"
  end

  add_index "carts", ["package_id"], :name => "index_carts_on_package_id"
  add_index "carts", ["user_id"], :name => "index_carts_on_user_id"

  create_table "dependent_products", :force => true do |t|
    t.integer  "product_id"
    t.integer  "dependency_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_products", :force => true do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "product_location"
    t.boolean  "finalized",        :default => false
  end

  create_table "orders", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "terms"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "complete"
    t.string   "stripe_invoice_id"
    t.boolean  "restricted_aware"
  end

  add_index "orders", ["user_id"], :name => "index_orders_on_user_id"

  create_table "packaged_products", :force => true do |t|
    t.integer  "package_id"
    t.integer  "product_id"
    t.integer  "included_amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "packages", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "price",       :precision => 8, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "list_order"
  end

  create_table "photos", :force => true do |t|
    t.integer  "blog_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.integer  "product_id"
    t.integer  "package_id"
  end

  add_index "photos", ["blog_id"], :name => "index_photos_on_blog_id"
  add_index "photos", ["package_id"], :name => "index_photos_on_package_id"
  add_index "photos", ["product_id"], :name => "index_photos_on_product_id"

  create_table "products", :force => true do |t|
    t.string   "item_name"
    t.text     "description"
    t.decimal  "price",               :precision => 8, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cart_id"
    t.string   "unit_number"
    t.boolean  "monitoring_addon"
    t.string   "list_category"
    t.integer  "list_order"
    t.boolean  "dependent_item"
    t.boolean  "interactive_service"
    t.boolean  "requires_location"
    t.integer  "combo_id"
    t.boolean  "combo_item"
  end

  add_index "products", ["cart_id"], :name => "index_products_on_cart_id"

  create_table "states", :force => true do |t|
    t.string   "abbreviation"
    t.string   "full_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "supports", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.string   "city"
    t.integer  "state_id"
    t.string   "zipcode"
    t.string   "support_type"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "systems", :force => true do |t|
    t.integer  "product_id"
    t.integer  "package_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "systems", ["package_id"], :name => "index_systems_on_package_id"
  add_index "systems", ["product_id"], :name => "index_systems_on_product_id"

  create_table "user_dependent_products", :force => true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_dependent_products", ["product_id"], :name => "index_user_dependent_products_on_product_id"
  add_index "user_dependent_products", ["user_id"], :name => "index_user_dependent_products_on_user_id"

  create_table "user_interactive_products", :force => true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_interactive_products", ["product_id"], :name => "index_user_interactive_products_on_product_id"
  add_index "user_interactive_products", ["user_id"], :name => "index_user_interactive_products_on_user_id"

  create_table "user_sessions", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.boolean  "terms"
    t.string   "username"
    t.string   "stripe_id"
    t.string   "stripe_plan_id"
    t.integer  "account_id"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "single_access_token"
    t.string   "perishable_token"
    t.integer  "login_count"
    t.integer  "failed_login_count"
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.boolean  "admin_user"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "package_id"
  end

  add_index "users", ["account_id"], :name => "index_users_on_account_id"
  add_index "users", ["package_id"], :name => "index_users_on_package_id"

end
