# == Schema Information
#
# Table name: cart_items
#
#  id         :integer          not null, primary key
#  product_id :integer
#  cart_id    :integer
#  notes      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  package_id :integer
#

require 'test_helper'

class CartItemTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
