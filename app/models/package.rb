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
  
  #Validations
  validates :name, :presence => true, :uniqueness => true
  validates :description, :presence => true
  validates :price, :format => { :with => /^\d+??(?:\.\d{0,2})?$/ }, :numericality => {:greater_than => 0, :less_than => 1000}
  
  #Associations
  has_many :photos, :dependent => :destroy
  
  #Assets
  accepts_nested_attributes_for :photos, :allow_destroy => true, :reject_if => lambda { |a| a[:attachment].blank? }
end