# == Schema Information
#
# Table name: products
#
#  id           :integer(4)      not null, primary key
#  item_name    :string(255)
#  description  :text
#  alarm_system :boolean(1)
#  addons       :boolean(1)
#  price        :decimal(8, 2)
#  created_at   :datetime
#  updated_at   :datetime
#

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
