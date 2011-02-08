# == Schema Information
#
# Table name: cart_items
#
#  id         :integer(4)      not null, primary key
#  product_id :integer(4)
#  cart_id    :integer(4)
#  notes      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class CartItemTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
