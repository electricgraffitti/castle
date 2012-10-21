# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  product_id :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
