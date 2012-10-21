# == Schema Information
#
# Table name: products
#
#  id                  :integer          not null, primary key
#  item_name           :string(255)
#  description         :text
#  price               :decimal(8, 2)
#  created_at          :datetime
#  updated_at          :datetime
#  cart_id             :integer
#  unit_number         :string(255)
#  monitoring_addon    :boolean
#  list_category       :string(255)
#  list_order          :integer
#  dependent_item      :boolean
#  interactive_service :boolean
#  requires_location   :boolean
#  combo_id            :integer
#  combo_item          :boolean
#

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
