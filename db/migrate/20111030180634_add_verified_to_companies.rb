class AddVerifiedToCompanies < ActiveRecord::Migration
  def self.up
    add_column :companies, :verified, :boolean
  end

  def self.down
    remove_column :companies, :verified
  end
end
