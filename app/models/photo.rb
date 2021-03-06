# == Schema Information
#
# Table name: photos
#
#  id                      :integer          not null, primary key
#  blog_id                 :integer
#  created_at              :datetime
#  updated_at              :datetime
#  attachment_file_name    :string(255)
#  attachment_content_type :string(255)
#  attachment_file_size    :integer
#  attachment_updated_at   :datetime
#  product_id              :integer
#  package_id              :integer
#

class Photo < ActiveRecord::Base
  
  
  #Associations
  belongs_to :blog
  belongs_to :product
  belongs_to :package
  
  #Paperclip
  has_attached_file :attachment,
                    :styles => {:medium => "650x323#", :small => "300x169#", :showcase => "200x200#", :thumb => "178x88#", :tiny => "89x44#"},
                    :url => '/photos/:id/:style_:basename.:extension',
                    :path => ":rails_root/public/photos/:id/:style_:basename.:extension"
end
