# == Schema Information
#
# Table name: products
#
#  id           :integer(4)      not null, primary key
#  item_name    :string(255)
#  description  :text
#  alarm_system :boolean(1)
#  addons       :boolean(1)
#  price        :decimal(8, 2)
#  created_at   :datetime
#  updated_at   :datetime
#

class Product < ActiveRecord::Base
  
  #Validations
  validates :item_name, :presence => true, :uniqueness => true
  validates :description, :presence => true
  validates :price, :format => { :with => /^\d+??(?:\.\d{0,2})?$/ }, :numericality => {:greater_than => 0, :less_than => 1000}
  
  #Scopes
    scope :system, where("alarm_system = ?", true)
    scope :peripherals, where("addons = ?", true)
  
  #Associations
  has_many :photos, :dependent => :destroy
  
  #Assets
  accepts_nested_attributes_for :photos, :allow_destroy => true, :reject_if => lambda { |a| a[:attachment].blank? }
end
