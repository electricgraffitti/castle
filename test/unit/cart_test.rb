# == Schema Information
#
# Table name: carts
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  complete   :boolean(1)
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class CartTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
