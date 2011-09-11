class AddUsedToCouppons < ActiveRecord::Migration
  def self.up
    add_column :couppons, :used, :boolean
  end

  def self.down
    remove_column :couppons, :used
  end
end
