class AddLongToCompanies < ActiveRecord::Migration
  def self.up
    add_column :companies, :long, :float
  end

  def self.down
    remove_column :companies, :long
  end
end
