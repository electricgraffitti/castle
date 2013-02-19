# == Schema Information
#
# Table name: orders
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  terms             :boolean
#  created_at        :datetime
#  updated_at        :datetime
#  complete          :boolean
#  stripe_invoice_id :string(255)
#  restricted_aware  :boolean
#

require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
