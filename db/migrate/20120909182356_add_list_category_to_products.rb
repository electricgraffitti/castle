class AddListCategoryToProducts < ActiveRecord::Migration
  def change
    add_column :products, :list_category, :string
  end
end
