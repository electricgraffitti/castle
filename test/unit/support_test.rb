# == Schema Information
#
# Table name: supports
#
#  id           :integer          not null, primary key
#  first_name   :string(255)
#  last_name    :string(255)
#  email        :string(255)
#  phone        :string(255)
#  city         :string(255)
#  state_id     :integer
#  zipcode      :string(255)
#  support_type :string(255)
#  comments     :text
#  created_at   :datetime
#  updated_at   :datetime
#

require 'test_helper'

class SupportTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
