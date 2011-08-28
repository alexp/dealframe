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

ActiveRecord::Schema.define(:version => 20110828112925) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "icon_url"
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
    t.text     "description"
    t.string   "phone_number"
    t.string   "email"
    t.string   "logo_url"
    t.integer  "category_id"
    t.string   "website_url"
    t.string   "opening_hrs"
    t.string   "first_photo_url"
    t.string   "second_photo_url"
    t.float    "lat"
    t.float    "long"
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
    t.decimal  "value",               :precision => 10, :scale => 0
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
    t.string   "invoice_description"
    t.string   "map_iframe"
  end

  add_index "offers", ["category_id"], :name => "index_offers_on_category_id"

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "encrypted_password"
    t.string   "surname"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
