class AddCategoryIdToOffers < ActiveRecord::Migration
  def self.up
    add_column :offers, :category_id, :integer
    add_index :offers, :category_id
  end

  def self.down
    remove_column :offers, :category_id
  end
end
