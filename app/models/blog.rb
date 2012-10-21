# == Schema Information
#
# Table name: blogs
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Blog < ActiveRecord::Base
  
  #Validations
  validates :title, :presence => true
  validates :description, :presence => true
  
  #Associations
  has_many :photos, :dependent => :destroy
  accepts_nested_attributes_for :photos, :allow_destroy => true, :reject_if => lambda { |a| a[:attachment].blank? }
  
  #Assets
  
  
end
