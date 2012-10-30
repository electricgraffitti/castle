require 'spec_helper'

describe "user_dependent_products/edit" do
  before(:each) do
    @user_dependent_product = assign(:user_dependent_product, stub_model(UserDependentProduct,
      :user_id => 1,
      :product_id => 1
    ))
  end

  it "renders the edit user_dependent_product form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => user_dependent_products_path(@user_dependent_product), :method => "post" do
      assert_select "input#user_dependent_product_user_id", :name => "user_dependent_product[user_id]"
      assert_select "input#user_dependent_product_product_id", :name => "user_dependent_product[product_id]"
    end
  end
end
