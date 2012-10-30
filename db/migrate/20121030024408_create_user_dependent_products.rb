class CreateUserDependentProducts < ActiveRecord::Migration
  def change
    create_table :user_dependent_products do |t|
      t.integer :user_id
      t.integer :product_id

      t.timestamps
    end
  end
end
