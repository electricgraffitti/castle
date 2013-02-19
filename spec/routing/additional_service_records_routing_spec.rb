require "spec_helper"

describe AdditionalServiceRecordsController do
  describe "routing" do

    it "routes to #index" do
      get("/additional_service_records").should route_to("additional_service_records#index")
    end

    it "routes to #new" do
      get("/additional_service_records/new").should route_to("additional_service_records#new")
    end

    it "routes to #show" do
      get("/additional_service_records/1").should route_to("additional_service_records#show", :id => "1")
    end

    it "routes to #edit" do
      get("/additional_service_records/1/edit").should route_to("additional_service_records#edit", :id => "1")
    end

    it "routes to #create" do
      post("/additional_service_records").should route_to("additional_service_records#create")
    end

    it "routes to #update" do
      put("/additional_service_records/1").should route_to("additional_service_records#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/additional_service_records/1").should route_to("additional_service_records#destroy", :id => "1")
    end

  end
end
