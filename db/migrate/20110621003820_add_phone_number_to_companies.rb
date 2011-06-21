class AddPhoneNumberToCompanies < ActiveRecord::Migration
  def self.up
    add_column :companies, :phone_number, :string
  end

  def self.down
    remove_column :companies, :phone_number
  end
end
