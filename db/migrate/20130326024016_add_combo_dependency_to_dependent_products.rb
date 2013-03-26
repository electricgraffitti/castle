class AddComboDependencyToDependentProducts < ActiveRecord::Migration
  def change
    add_column :products, :secondary_product, :integer
  end
end
