# == Schema Information
#
# Table name: products
#
#  id               :integer(4)      not null, primary key
#  item_name        :string(255)
#  description      :text
#  price            :decimal(8, 2)
#  created_at       :datetime
#  updated_at       :datetime
#  cart_id          :integer(4)
#  unit_number      :string(255)
#  monitoring_addon :boolean(1)
#  list_order       :integer(4)
#

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
