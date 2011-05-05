# == Schema Information
#
# Table name: billing_records
#
#  id          :integer(4)      not null, primary key
#  terms       :boolean(1)
#  city        :string(255)
#  address     :string(255)
#  billing_zip :string(255)
#  phone       :string(255)
#  first_name  :string(255)
#  last_name   :string(255)
#  state_id    :integer(4)
#  email       :string(255)
#  order_id    :integer(4)
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
