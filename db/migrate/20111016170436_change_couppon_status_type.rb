class ChangeCoupponStatusType < ActiveRecord::Migration
  def self.up
    change_column :couppons, :status, :string
  end

  def self.down
    change_column :couppons, :status, :integer
  end
end
