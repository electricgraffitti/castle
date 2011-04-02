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
#  list_order       :integer(4)
#

class Product < ActiveRecord::Base
  
  #Validations
  validates :item_name, :presence => true, :uniqueness => true
  validates :description, :presence => true
  validates :price, :format => { :with => /^\d+??(?:\.\d{0,2})?$/ }, :numericality => {:greater_than => 0, :less_than => 1000}
  
  #Scopes
  scope :monitoring, where("monitoring_addon = ?", true)
  scope :product_order, :order => "list_order"
  # scope :system_listing, order("package_id")
  
  #Associations
  has_many :photos, :dependent => :destroy
  has_many :systems
  has_many :packages, :through => :systems
  has_many :order_products
  has_many :orders, :through => :order_products
  has_many :dependent_products
  has_many :dependencies, :through => :dependent_products
  
  #Assets
  accepts_nested_attributes_for :photos, :allow_destroy => true, :reject_if => lambda { |a| a[:attachment].blank? }
  
  # Methods
  
  def check_dependencies(cart)
    
    # Setup empty Arrays
    dep = []
    cis = []
    
    # Create Array of Dependency ID's
    self.dependencies.each do |d|
      dep.push(d.id)
    end
    
    # Create Array of product ID's in cart
    cart.items.each do |ci|
      cis.push(ci.cart_item)
    end
    
    # Remove the ID if it is in both the Cart and a Dependency
    cis.each do |c|
      if dep.include?(c)
        dep.delete(c)
      end
    end
    
    if dep.empty? 
      return false
    else
      return existing_dependencies(dep)
    end
  end
  
  def existing_dependencies(dep)
    
    products = []
    
    dep.each do |d|
      product = Product.find(d)
      products.push(product)
    end
    return products
  end
  
end
