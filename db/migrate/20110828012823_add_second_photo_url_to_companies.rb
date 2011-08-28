class AddSecondPhotoUrlToCompanies < ActiveRecord::Migration
  def self.up
    add_column :companies, :second_photo_url, :string
  end

  def self.down
    remove_column :companies, :second_photo_url
  end
end
