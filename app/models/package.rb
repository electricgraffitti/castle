# == Schema Information
#
# Table name: packages
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  description :text
#  price       :decimal(8, 2)
#  created_at  :datetime
#  updated_at  :datetime
#

class Package < ActiveRecord::Base
  
  # Validations
  validates :name, :presence => true, :uniqueness => true
  validates :description, :presence => true
  validates :price, :format => { :with => /^\d+??(?:\.\d{0,2})?$/ }, :numericality => {:greater_than => 0, :less_than => 1000}
  
  # Associations
  has_many :photos, :dependent => :destroy
  accepts_nested_attributes_for :photos, :allow_destroy => true, :reject_if => lambda { |a| a[:attachment].blank? }
  
  # has_many :products
  has_many :carts
  has_many :cart_items
  has_many :systems
  accepts_nested_attributes_for :systems
  has_many :products, :through => :systems
  
  # Methods
  
  before_destroy :ensure_not_referenced_by_any_cart_item
  
  def ensure_not_referenced_by_any_cart_item
    if cart_items.count.zero?
      return true
    else
      errors[:base] << "Items in cart are Present"
      return false
  end
end
  
end
