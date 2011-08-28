class AddCategoryIdToCompanies < ActiveRecord::Migration
  def self.up
    add_column :companies, :category_id, :int
  end

  def self.down
    remove_column :companies, :category_id
  end
end
