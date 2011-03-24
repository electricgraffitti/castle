# == Schema Information
#
# Table name: accounts
#
#  id         :integer(4)      not null, primary key
#  product_id :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class Account < ActiveRecord::Base
end
