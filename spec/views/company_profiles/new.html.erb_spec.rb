require 'spec_helper'

describe "company_profiles/new.html.erb" do
  before(:each) do
    assign(:company_profile, stub_model(CompanyProfile,
      :name => "MyString",
      :website_url => "MyString",
      :type => "MyString",
      :open_times => "MyString",
      :lat => 1.5,
      :lng => 1.5
    ).as_new_record)
  end

  it "renders new company_profile form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => company_profiles_path, :method => "post" do
      assert_select "input#company_profile_name", :name => "company_profile[name]"
      assert_select "input#company_profile_website_url", :name => "company_profile[website_url]"
      assert_select "input#company_profile_type", :name => "company_profile[type]"
      assert_select "input#company_profile_open_times", :name => "company_profile[open_times]"
      assert_select "input#company_profile_lat", :name => "company_profile[lat]"
      assert_select "input#company_profile_lng", :name => "company_profile[lng]"
    end
  end
end
