class AddFinePrintToOffers < ActiveRecord::Migration
  def self.up
    add_column :offers, :fine_print, :text
  end

  def self.down
    remove_column :offers, :fine_print
  end
end
