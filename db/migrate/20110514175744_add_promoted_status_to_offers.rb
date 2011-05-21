class AddPromotedStatusToOffers < ActiveRecord::Migration
  def self.up
    add_column :offers, :promoted_status, :integer
  end

  def self.down
    remove_column :offers, :promoted_status
  end
end
