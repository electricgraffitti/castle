# == Schema Information
#
# Table name: additional_service_records
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  cross_street       :string(255)
#  permit_info        :text
#  secondary_phone    :string(255)
#  subdivision        :string(255)
#  emergency_name     :string(255)
#  emergency_password :string(255)
#  secondary_address  :string(255)
#  secondary_city     :string(255)
#  state_id           :integer
#  secondary_zip      :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'spec_helper'

describe AdditionalServiceRecord do
  pending "add some examples to (or delete) #{__FILE__}"
end
