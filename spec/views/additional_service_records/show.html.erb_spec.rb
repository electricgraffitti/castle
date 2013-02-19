require 'spec_helper'

describe "additional_service_records/show" do
  before(:each) do
    @additional_service_record = assign(:additional_service_record, stub_model(AdditionalServiceRecord,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Cross Street/)
    rendered.should match(/MyText/)
    rendered.should match(/Secondary Phone/)
    rendered.should match(/Subdivision/)
    rendered.should match(/Emergency Name/)
    rendered.should match(/Emergency Password/)
    rendered.should match(/Secondary Address/)
    rendered.should match(/Secondary City/)
    rendered.should match(/2/)
    rendered.should match(/Secondary Zip/)
  end
end
