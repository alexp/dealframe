class AddWebsiteUrlToCompanies < ActiveRecord::Migration
  def self.up
    add_column :companies, :website_url, :string
  end

  def self.down
    remove_column :companies, :website_url
  end
end
