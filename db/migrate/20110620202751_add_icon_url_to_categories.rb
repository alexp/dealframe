class AddIconUrlToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :icon_url, :string
  end

  def self.down
    remove_column :categories, :icon_url
  end
end
