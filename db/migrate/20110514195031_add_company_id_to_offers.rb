class AddCompanyIdToOffers < ActiveRecord::Migration
  def self.up
    add_column :offers, :company_id, :integer
  end

  def self.down
    remove_column :offers, :company_id
  end
end
