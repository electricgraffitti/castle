# == Schema Information
#
# Table name: order_products
#
#  id         :integer(4)      not null, primary key
#  order_id   :integer(4)
#  product_id :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class OrderProductTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
