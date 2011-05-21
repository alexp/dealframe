class ChangeOfferLengthToEndDate < ActiveRecord::Migration
  def self.up
    remove_column :offers, :deal_length
    add_column :offers, :end_date, :datetime
  end

  def self.down
    remove_column :offers, :end_date
    add_column :offers, :deal_length, :integer
  end
end
