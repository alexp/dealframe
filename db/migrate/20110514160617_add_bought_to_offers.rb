class AddBoughtToOffers < ActiveRecord::Migration
  def self.up
    add_column :offers, :bought, :integer
  end

  def self.down
    remove_column :offers, :bought
  end
end
