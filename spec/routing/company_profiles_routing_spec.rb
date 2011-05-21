require "spec_helper"

describe CompanyProfilesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/company_profiles" }.should route_to(:controller => "company_profiles", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/company_profiles/new" }.should route_to(:controller => "company_profiles", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/company_profiles/1" }.should route_to(:controller => "company_profiles", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/company_profiles/1/edit" }.should route_to(:controller => "company_profiles", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/company_profiles" }.should route_to(:controller => "company_profiles", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/company_profiles/1" }.should route_to(:controller => "company_profiles", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/company_profiles/1" }.should route_to(:controller => "company_profiles", :action => "destroy", :id => "1")
    end

  end
end
