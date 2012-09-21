class AddUserIdToBillingRecords < ActiveRecord::Migration
  def change
    add_column :billing_records, :user_id, :integer
    add_index :billing_records, :user_id
  end
end
