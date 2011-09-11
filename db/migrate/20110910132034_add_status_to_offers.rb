class AddStatusToOffers < ActiveRecord::Migration
  def self.up
    add_column :offers, :status, :string
  end

  def self.down
    remove_column :offers, :status
  end
end
