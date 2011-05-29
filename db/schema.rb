# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110529092007) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", :force => true do |t|
    t.string   "full_name"
    t.string   "short_name"
    t.text     "address"
    t.string   "zip_code"
    t.string   "city"
    t.string   "nip"
    t.string   "regon"
    t.boolean  "vat"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "company_profiles", :force => true do |t|
    t.string   "name"
    t.string   "website_url"
    t.string   "type"
    t.string   "open_times"
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "couppons", :force => true do |t|
    t.integer  "company_id"
    t.integer  "user_id"
    t.integer  "offer_id"
    t.integer  "couppon_code"
    t.string   "security_code"
    t.datetime "expiration_date"
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "offers", :force => true do |t|
    t.datetime "start_date"
    t.datetime "expiration_date"
    t.decimal  "value",           :precision => 10, :scale => 0
    t.integer  "discount"
    t.string   "title"
    t.text     "description"
    t.string   "photo_url"
    t.float    "lat"
    t.float    "lgn"
    t.text     "additional_info"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
    t.datetime "end_date"
    t.integer  "bought"
    t.integer  "promoted_status"
    t.integer  "company_id"
    t.text     "fine_print"
    t.text     "details"
  end

  add_index "offers", ["category_id"], :name => "index_offers_on_category_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

end
