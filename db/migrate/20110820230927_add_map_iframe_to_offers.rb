class AddMapIframeToOffers < ActiveRecord::Migration
  def self.up
    add_column :offers, :map_iframe, :string
  end

  def self.down
    remove_column :offers, :map_iframe
  end
end
