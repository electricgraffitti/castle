class RemoveFieldsFromBillingRecords < ActiveRecord::Migration
  def up
  	remove_column :billing_records, :first_name
  	remove_column :billing_records, :last_name
  	remove_column :billing_records, :email
  	remove_column :billing_records, :phone
    remove_column :billing_records, :terms
  end

  def down
  	add_column :billing_records, :first_name, :string
  	add_column :billing_records, :last_name, :string
  	add_column :billing_records, :email, :string
  	add_column :billing_records, :phone, :string
    add_column :billing_records, :terms, :integer
  end
end
