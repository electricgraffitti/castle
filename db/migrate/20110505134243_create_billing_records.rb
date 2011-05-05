class CreateBillingRecords < ActiveRecord::Migration
  def self.up
    create_table :billing_records do |t|
      t.boolean :terms
      t.string :city
      t.string :address
      t.string :billing_zip
      t.string :phone
      t.string :first_name
      t.string :last_name
      t.integer :state_id
      t.string :email
      t.integer :order_id
      t.timestamps
    end
  end

  def self.down
    drop_table :billing_records
  end
end
