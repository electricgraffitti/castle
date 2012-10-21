# == Schema Information
#
# Table name: order_products
#
#  id               :integer          not null, primary key
#  order_id         :integer
#  product_id       :integer
#  created_at       :datetime
#  updated_at       :datetime
#  product_location :string(255)
#  finalized        :boolean
#

require 'test_helper'

class OrderProductTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
