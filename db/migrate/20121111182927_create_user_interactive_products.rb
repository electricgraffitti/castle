class CreateUserInteractiveProducts < ActiveRecord::Migration
  def change
    create_table :user_interactive_products do |t|
      t.integer :user_id
      t.integer :product_id

      t.timestamps
    end
    add_index :user_interactive_products, :user_id
    add_index :user_interactive_products, :product_id
  end
end
