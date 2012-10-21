# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  product_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Account < ActiveRecord::Base
end
