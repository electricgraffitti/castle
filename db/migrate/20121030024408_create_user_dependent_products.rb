class CreateUserDependentProducts < ActiveRecord::Migration
  def change
    create_table :user_dependent_products do |t|
      t.integer :user_id
      t.integer :product_id

      t.timestamps
    end
    add_index :user_dependent_products, :user_id
    add_index :user_dependent_products, :product_id
  end
end
