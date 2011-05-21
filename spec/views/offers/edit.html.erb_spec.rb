require 'spec_helper'

describe "offers/edit.html.erb" do
  before(:each) do
    @offer = assign(:offer, stub_model(Offer,
      :value => "9.99",
      :discount => 1,
      :title => "MyString",
      :description => "MyText",
      :photo_url => "MyString",
      :lat => 1.5,
      :lgn => 1.5,
      :additional_info => "MyText"
    ))
  end

  it "renders the edit offer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => offers_path(@offer), :method => "post" do
      assert_select "input#offer_value", :name => "offer[value]"
      assert_select "input#offer_discount", :name => "offer[discount]"
      assert_select "input#offer_title", :name => "offer[title]"
      assert_select "textarea#offer_description", :name => "offer[description]"
      assert_select "input#offer_photo_url", :name => "offer[photo_url]"
      assert_select "input#offer_lat", :name => "offer[lat]"
      assert_select "input#offer_lgn", :name => "offer[lgn]"
      assert_select "textarea#offer_additional_info", :name => "offer[additional_info]"
    end
  end
end
