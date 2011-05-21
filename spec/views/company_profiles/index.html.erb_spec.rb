require 'spec_helper'

describe "company_profiles/index.html.erb" do
  before(:each) do
    assign(:company_profiles, [
      stub_model(CompanyProfile,
        :name => "Name",
        :website_url => "Website Url",
        :type => "Type",
        :open_times => "Open Times",
        :lat => 1.5,
        :lng => 1.5
      ),
      stub_model(CompanyProfile,
        :name => "Name",
        :website_url => "Website Url",
        :type => "Type",
        :open_times => "Open Times",
        :lat => 1.5,
        :lng => 1.5
      )
    ])
  end

  it "renders a list of company_profiles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Website Url".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Open Times".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end
