require "spec_helper"

describe UserInteractiveProductsController do
  describe "routing" do

    it "routes to #index" do
      get("/user_interactive_products").should route_to("user_interactive_products#index")
    end

    it "routes to #new" do
      get("/user_interactive_products/new").should route_to("user_interactive_products#new")
    end

    it "routes to #show" do
      get("/user_interactive_products/1").should route_to("user_interactive_products#show", :id => "1")
    end

    it "routes to #edit" do
      get("/user_interactive_products/1/edit").should route_to("user_interactive_products#edit", :id => "1")
    end

    it "routes to #create" do
      post("/user_interactive_products").should route_to("user_interactive_products#create")
    end

    it "routes to #update" do
      put("/user_interactive_products/1").should route_to("user_interactive_products#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/user_interactive_products/1").should route_to("user_interactive_products#destroy", :id => "1")
    end

  end
end
