# == Schema Information
#
# Table name: products
#
#  id                  :integer          not null, primary key
#  item_name           :string(255)
#  description         :text
#  price               :decimal(8, 2)
#  created_at          :datetime
#  updated_at          :datetime
#  cart_id             :integer
#  unit_number         :string(255)
#  monitoring_addon    :boolean
#  list_category       :string(255)
#  list_order          :integer
#  dependent_item      :boolean
#  interactive_service :boolean
#  requires_location   :boolean
#  combo_id            :integer
#  combo_item          :boolean
#

class Product < ActiveRecord::Base
  
  #Validations
  validates :item_name, :presence => true, :uniqueness => true
  validates :description, :presence => true
  validates :price, :format => { :with => /^\d+??(?:\.\d{0,2})?$/ }, :numericality => {:greater_than => 0, :less_than => 1000}
  
  #Scopes
  scope :monitoring, where("monitoring_addon = ?", true)
  scope :product_order, :order => "list_order"
  scope :combo_items, where("combo_item = ?", true)
  
  #Associations
  has_many :photos, :dependent => :destroy
  has_many :systems, :dependent => :destroy
  has_many :packages, :through => :systems
  has_many :order_products
  has_many :orders, :through => :order_products
  has_many :dependent_products
  has_many :dependencies, :through => :dependent_products
  has_many :user_dependent_products
  has_many :user_interactive_products
  
  #Assets
  accepts_nested_attributes_for :photos, :allow_destroy => true, :reject_if => lambda { |a| a[:attachment].blank? }
  
  # Methods
  
  def dependent_checkbox
    if self.dependent_products
      return true
    else
      return false
    end
  end

  def set_product_interactive_dependent_ids
    ids = []
    self.dependencies.each do |d|
      if d.interactive_service
        ids.push(d.id)
      end
    end
    return ids
  end

  def set_product_dependent_ids
    ids = []
    self.dependencies.each do |d|
      unless d.interactive_service
        ids.push(d.id)
      end
    end
    return ids
  end

  def set_cart_ids(cart)
    ids = []
    cart.items.each do |ci|
      ids.push(ci.cart_item)
    end
    return ids
  end

  def merge_item_arrays(a,b,c)
    d = a + b + c
    return d.uniq
  end
  
  def check_dependencies(cart, current_user = nil)
    
    # Setup Dependent and Interactive Product ID Arrays
    item_inter_dep_ids = self.set_product_interactive_dependent_ids
    item_dep_ids = self.set_product_dependent_ids

    # Setup Cart Item and Current User Dependent Product ID arrays
    cart_item_ids = set_cart_ids(cart)
    user_dep_ids = current_user ? current_user.dependent_product_ids : []
    user_interactive_dep_ids = current_user ? current_user.interactive_product_ids : []

    # Merge Cart Item IDs and Current User Dependent Item IDs to make a single array of item ID's 
    # that are either in the Cart or the current user has already purchased.
    cart_and_user_item_ids = merge_item_arrays(cart_item_ids, user_dep_ids, user_interactive_dep_ids)
    
    # Remove the ID if it is in cart_and_user_item_ids and either the item_inter_dep_ids or item_dep_ids
    cart_and_user_item_ids.each do |c|

      if item_dep_ids.include?(c)
        item_dep_ids.delete(c)
      else
        self.dependencies.each do |dep_prd|
          if dep_prd.secondary_product == c
            item_dep_ids.delete(dep_prd.id)
          end
        end
      end
      
      if item_inter_dep_ids.include?(c)
        item_inter_dep_ids = []
      end
    end
    
    if item_dep_ids.empty? && item_inter_dep_ids.empty?
      return false
    else
      return existing_dependencies(item_dep_ids, item_inter_dep_ids)
    end
  end
  
  def existing_dependencies(item_dep_ids, item_inter_dep_ids)
    
    products = []
    
    unless item_dep_ids.empty?
      item_dep_ids.each do |d|
        product = Product.find(d)
        products.push(product)
      end
    end
    
    unless item_inter_dep_ids.empty?
      item_inter_dep_ids.each do |d|
        product = Product.find(d)
        products.push(product)
      end
    end 
    return products
  end
  
  def check_for_combo_items(items)
    
    if self.combo_item
      items.each do |item|
        items.delete_if {|item| item.combo_id == self.id }
        if item.cart_item == self.id
          item.decrement_quantity
        end
      end
      return items
    else
      items.each do |item|
        if self.combo_id && item.cart_item == self.id
          item.decrement_quantity
        end
        items.delete_if {|item| item.combo_item && item.cart_item == self.combo_id }
      end
      return items
    end 
  end
  
  def check_for_interactive(items)
    
    # Check self to see if item is and interactive item
    if self.interactive_service
      # if interactive loop over current items to see if it already contains an interactive item
      items.each do |item|
        if item.interactive == true
          items.delete(item)
        end
      end
      return items
    else
      return items
    end
  end

  def category1
    list_category == "Category-1" ? true : false
  end

  def category2
    list_category == "Category-2" ? true : false
  end

  def category3
    list_category == "Category-3" ? true : false
  end

  def category4
    list_category == "Category-4" ? true : false
  end  

  def category5
    list_category == "Category-5" ? true : false
  end

  def remote_control_device
    category2
  end
  
end
