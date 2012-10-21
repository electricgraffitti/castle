# == Schema Information
#
# Table name: billing_records
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  order_id    :integer
#  city        :string(255)
#  address     :string(255)
#  billing_zip :string(255)
#  state_id    :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require 'test_helper'

class BillingRecordTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
