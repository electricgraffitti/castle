require 'spec_helper'

describe "user_interactive_products/edit" do
  before(:each) do
    @user_interactive_product = assign(:user_interactive_product, stub_model(UserInteractiveProduct,
      :user_id => 1,
      :product_id => 1
    ))
  end

  it "renders the edit user_interactive_product form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => user_interactive_products_path(@user_interactive_product), :method => "post" do
      assert_select "input#user_interactive_product_user_id", :name => "user_interactive_product[user_id]"
      assert_select "input#user_interactive_product_product_id", :name => "user_interactive_product[product_id]"
    end
  end
end
