# == Schema Information
#
# Table name: packages
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  price       :decimal(8, 2)
#  created_at  :datetime
#  updated_at  :datetime
#  list_order  :integer
#

require 'test_helper'

class PackageTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
