require 'spec_helper'

describe "additional_service_records/new" do
  before(:each) do
    assign(:additional_service_record, stub_model(AdditionalServiceRecord,
      :user_id => 1,
      :cross_street => "MyString",
      :permit_info => "MyText",
      :secondary_phone => "MyString",
      :subdivision => "MyString",
      :emergency_name => "MyString",
      :emergency_password => "MyString",
      :secondary_address => "MyString",
      :secondary_city => "MyString",
      :state_id => 1,
      :secondary_zip => "MyString"
    ).as_new_record)
  end

  it "renders new additional_service_record form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => additional_service_records_path, :method => "post" do
      assert_select "input#additional_service_record_user_id", :name => "additional_service_record[user_id]"
      assert_select "input#additional_service_record_cross_street", :name => "additional_service_record[cross_street]"
      assert_select "textarea#additional_service_record_permit_info", :name => "additional_service_record[permit_info]"
      assert_select "input#additional_service_record_secondary_phone", :name => "additional_service_record[secondary_phone]"
      assert_select "input#additional_service_record_subdivision", :name => "additional_service_record[subdivision]"
      assert_select "input#additional_service_record_emergency_name", :name => "additional_service_record[emergency_name]"
      assert_select "input#additional_service_record_emergency_password", :name => "additional_service_record[emergency_password]"
      assert_select "input#additional_service_record_secondary_address", :name => "additional_service_record[secondary_address]"
      assert_select "input#additional_service_record_secondary_city", :name => "additional_service_record[secondary_city]"
      assert_select "input#additional_service_record_state_id", :name => "additional_service_record[state_id]"
      assert_select "input#additional_service_record_secondary_zip", :name => "additional_service_record[secondary_zip]"
    end
  end
end
