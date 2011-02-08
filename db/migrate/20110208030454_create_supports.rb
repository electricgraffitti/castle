class CreateSupports < ActiveRecord::Migration
  def self.up
    create_table :supports do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :city
      t.integer :state_id
      t.string :zipcode
      t.string :support_type
      t.text :comments
      t.timestamps
    end
  end

  def self.down
    drop_table :supports
  end
end
