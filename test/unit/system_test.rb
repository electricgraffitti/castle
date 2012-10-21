# == Schema Information
#
# Table name: systems
#
#  id         :integer          not null, primary key
#  product_id :integer
#  package_id :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class SystemTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
