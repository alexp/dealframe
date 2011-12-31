class AddQuantitityToCouppons < ActiveRecord::Migration
  def self.up
    add_column :couppons, :quantity, :integer
  end

  def self.down
    remove_column :couppons, :quantity
  end
end
