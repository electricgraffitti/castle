require 'spec_helper'

describe "user_interactive_products/show" do
  before(:each) do
    @user_interactive_product = assign(:user_interactive_product, stub_model(UserInteractiveProduct,
      :user_id => 1,
      :product_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
