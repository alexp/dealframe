class AddLatToCompanies < ActiveRecord::Migration
  def self.up
    add_column :companies, :lat, :float
  end

  def self.down
    remove_column :companies, :lat
  end
end
