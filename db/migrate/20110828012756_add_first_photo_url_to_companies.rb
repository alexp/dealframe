class AddFirstPhotoUrlToCompanies < ActiveRecord::Migration
  def self.up
    add_column :companies, :first_photo_url, :string
  end

  def self.down
    remove_column :companies, :first_photo_url
  end
end
