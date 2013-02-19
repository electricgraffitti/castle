require 'spec_helper'

describe "additional_service_records/index" do
  before(:each) do
    assign(:additional_service_records, [
      stub_model(AdditionalServiceRecord,
        :user_id => 1,
        :cross_street => "Cross Street",
        :permit_info => "MyText",
        :secondary_phone => "Secondary Phone",
        :subdivision => "Subdivision",
        :emergency_name => "Emergency Name",
        :emergency_password => "Emergency Password",
        :secondary_address => "Secondary Address",
        :secondary_city => "Secondary City",
        :state_id => 2,
        :secondary_zip => "Secondary Zip"
      ),
      stub_model(AdditionalServiceRecord,
        :user_id => 1,
        :cross_street => "Cross Street",
        :permit_info => "MyText",
        :secondary_phone => "Secondary Phone",
        :subdivision => "Subdivision",
        :emergency_name => "Emergency Name",
        :emergency_password => "Emergency Password",
        :secondary_address => "Secondary Address",
        :secondary_city => "Secondary City",
        :state_id => 2,
        :secondary_zip => "Secondary Zip"
      )
    ])
  end

  it "renders a list of additional_service_records" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Cross Street".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Secondary Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Subdivision".to_s, :count => 2
    assert_select "tr>td", :text => "Emergency Name".to_s, :count => 2
    assert_select "tr>td", :text => "Emergency Password".to_s, :count => 2
    assert_select "tr>td", :text => "Secondary Address".to_s, :count => 2
    assert_select "tr>td", :text => "Secondary City".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Secondary Zip".to_s, :count => 2
  end
end
