# == Schema Information
#
# Table name: states
#
#  id           :integer          not null, primary key
#  abbreviation :string(255)
#  full_name    :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class State < ActiveRecord::Base
  
  has_many :supports
  has_many :billing_records
  has_many :additional_service_records
  
end
