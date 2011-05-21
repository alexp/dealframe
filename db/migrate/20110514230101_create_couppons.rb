class CreateCouppons < ActiveRecord::Migration
  def self.up
    create_table :couppons do |t|
      t.integer :company_id
      t.integer :user_id
      t.integer :offer_id
      t.integer :couppon_code
      t.string :security_code
      t.datetime :expiration_date
      t.boolean :status

      t.timestamps
    end
  end

  def self.down
    drop_table :couppons
  end
end
