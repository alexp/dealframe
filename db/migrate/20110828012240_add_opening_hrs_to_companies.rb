class AddOpeningHrsToCompanies < ActiveRecord::Migration
  def self.up
    add_column :companies, :opening_hrs, :string
  end

  def self.down
    remove_column :companies, :opening_hrs
  end
end
