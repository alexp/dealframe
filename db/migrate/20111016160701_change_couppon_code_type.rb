class ChangeCoupponCodeType < ActiveRecord::Migration
  def self.up
    change_column :couppons, :couppon_code, :string
  end

  def self.down
    change_column :couppons, :couppon_code, :integer
  end
end
