# == Schema Information
#
# Table name: packaged_products
#
#  id              :integer          not null, primary key
#  package_id      :integer
#  product_id      :integer
#  included_amount :integer
#  created_at      :datetime
#  updated_at      :datetime
#

require 'test_helper'

class PackagedProductTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
