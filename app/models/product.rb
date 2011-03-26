# == Schema Information
#
# Table name: products
#
#  id               :integer(4)      not null, primary key
#  item_name        :string(255)
#  description      :text
#  price            :decimal(8, 2)
#  created_at       :datetime
#  updated_at       :datetime
#  cart_id          :integer(4)
#  unit_number      :string(255)
#  monitoring_addon :boolean(1)
#

class Product < ActiveRecord::Base
  
  #Validations
  validates :item_name, :presence => true, :uniqueness => true
  validates :description, :presence => true
  validates :price, :format => { :with => /^\d+??(?:\.\d{0,2})?$/ }, :numericality => {:greater_than => 0, :less_than => 1000}
  
  #Scopes
  scope :monitoring, where("monitoring_addon = ?", true)
  # scope :system_listing, order("package_id")
  
  #Associations
  has_many :photos, :dependent => :destroy
  has_many :cart_items
  belongs_to :cart
  has_many :systems
  has_many :packages, :through => :systems
  
  #Assets
  accepts_nested_attributes_for :systems
  accepts_nested_attributes_for :photos, :allow_destroy => true, :reject_if => lambda { |a| a[:attachment].blank? }

  
end
