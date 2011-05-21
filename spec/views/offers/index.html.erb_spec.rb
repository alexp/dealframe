require 'spec_helper'

describe "offers/index.html.erb" do
  before(:each) do
    assign(:offers, [
      stub_model(Offer,
        :value => "9.99",
        :discount => 1,
        :title => "Title",
        :description => "MyText",
        :photo_url => "Photo Url",
        :lat => 1.5,
        :lgn => 1.5,
        :additional_info => "MyText"
      ),
      stub_model(Offer,
        :value => "9.99",
        :discount => 1,
        :title => "Title",
        :description => "MyText",
        :photo_url => "Photo Url",
        :lat => 1.5,
        :lgn => 1.5,
        :additional_info => "MyText"
      )
    ])
  end

  it "renders a list of offers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Photo Url".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
