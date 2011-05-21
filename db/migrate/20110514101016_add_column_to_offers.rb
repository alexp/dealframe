class AddColumnToOffers < ActiveRecord::Migration
  def self.up
    add_column :offers, :deal_length, :integer
  end

  def self.down
    remove_column :offers, :deal_length
  end
end
