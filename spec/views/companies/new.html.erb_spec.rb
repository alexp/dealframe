require 'spec_helper'

describe "companies/new.html.erb" do
  before(:each) do
    assign(:company, stub_model(Company,
      :full_name => "MyString",
      :short_name => "MyString",
      :address => "MyText",
      :zip_code => "MyString",
      :city => "MyString",
      :nip => "MyString",
      :regon => "MyString",
      :vat => false,
      :company_profile_id => 1
    ).as_new_record)
  end

  it "renders new company form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => companies_path, :method => "post" do
      assert_select "input#company_full_name", :name => "company[full_name]"
      assert_select "input#company_short_name", :name => "company[short_name]"
      assert_select "textarea#company_address", :name => "company[address]"
      assert_select "input#company_zip_code", :name => "company[zip_code]"
      assert_select "input#company_city", :name => "company[city]"
      assert_select "input#company_nip", :name => "company[nip]"
      assert_select "input#company_regon", :name => "company[regon]"
      assert_select "input#company_vat", :name => "company[vat]"
      assert_select "input#company_company_profile_id", :name => "company[company_profile_id]"
    end
  end
end
