require "spec_helper"

describe UserDependentProductsController do
  describe "routing" do

    it "routes to #index" do
      get("/user_dependent_products").should route_to("user_dependent_products#index")
    end

    it "routes to #new" do
      get("/user_dependent_products/new").should route_to("user_dependent_products#new")
    end

    it "routes to #show" do
      get("/user_dependent_products/1").should route_to("user_dependent_products#show", :id => "1")
    end

    it "routes to #edit" do
      get("/user_dependent_products/1/edit").should route_to("user_dependent_products#edit", :id => "1")
    end

    it "routes to #create" do
      post("/user_dependent_products").should route_to("user_dependent_products#create")
    end

    it "routes to #update" do
      put("/user_dependent_products/1").should route_to("user_dependent_products#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/user_dependent_products/1").should route_to("user_dependent_products#destroy", :id => "1")
    end

  end
end
