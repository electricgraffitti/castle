# == Schema Information
#
# Table name: states
#
#  id           :integer          not null, primary key
#  abbreviation :string(255)
#  full_name    :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

require 'test_helper'

class StateTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
