class AddInvoiceDescriptionToOffers < ActiveRecord::Migration
  def self.up
    add_column :offers, :invoice_description, :string
  end

  def self.down
    remove_column :offers, :invoice_description
  end
end
