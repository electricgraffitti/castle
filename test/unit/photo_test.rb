# == Schema Information
#
# Table name: photos
#
#  id                      :integer(4)      not null, primary key
#  blog_id                 :integer(4)
#  created_at              :datetime
#  updated_at              :datetime
#  attachment_file_name    :string(255)
#  attachment_content_type :string(255)
#  attachment_file_size    :integer(4)
#  attachment_updated_at   :datetime
#  product_id              :integer(4)
#

require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
