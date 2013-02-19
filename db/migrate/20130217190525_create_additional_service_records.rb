class CreateAdditionalServiceRecords < ActiveRecord::Migration
  def change
    create_table :additional_service_records do |t|
      t.integer :user_id
      t.string :cross_street
      t.text :permit_info
      t.string :secondary_phone
      t.string :subdivision
      t.string :emergency_name
      t.string :emergency_password
      t.string :secondary_address
      t.string :secondary_city
      t.integer :state_id
      t.string :secondary_zip

      t.timestamps
    end
  end
end
