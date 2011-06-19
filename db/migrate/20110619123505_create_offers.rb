class CreateOffers < ActiveRecord::Migration
  def self.up
    create_table :offers do |t|
      t.datetime :start_date
      t.datetime :expiration_date
      t.decimal :value
      t.integer :discount
      t.string :title
      t.text :description
      t.string :photo_url
      t.float :lat
      t.float :lgn
      t.text :additional_info

      t.timestamps
    end
  end

  def self.down
    drop_table :offers
  end
end
