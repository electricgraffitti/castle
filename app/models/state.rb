# == Schema Information
#
# Table name: states
#
#  id           :integer(4)      not null, primary key
#  abbreviation :string(255)
#  full_name    :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class State < ActiveRecord::Base
  
  has_many :supports
  
end
