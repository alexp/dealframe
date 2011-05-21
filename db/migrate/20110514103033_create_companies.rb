class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.string :full_name
      t.string :short_name
      t.text :address
      t.string :zip_code
      t.string :city
      t.string :nip
      t.string :regon
      t.boolean :vat

      t.timestamps
    end
  end

  def self.down
    drop_table :companies
  end
end
