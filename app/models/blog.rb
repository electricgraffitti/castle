# == Schema Information
#
# Table name: blogs
#
#  id          :integer(4)      not null, primary key
#  title       :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Blog < ActiveRecord::Base
  
  #Validations
  validates_presence_of :title, :on => :create, :message => "Must give a blog title"
  validates_presence_of :description, :on => :create, :message => "Must give a blog description"
  
  #Associations
  has_many :photos, :dependent => :destroy
  
  #Assets
    accepts_nested_attributes_for :photos, :allow_destroy => true, :reject_if => lambda { |a| a[:attachment].blank? }
  
end
