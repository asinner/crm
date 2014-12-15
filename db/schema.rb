# encoding: UTF-8
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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141214221021) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: true do |t|
    t.integer  "event_id"
    t.string   "line1"
    t.string   "line2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses", ["event_id"], name: "index_addresses_on_event_id", using: :btree

  create_table "companies", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "costs", force: true do |t|
    t.integer  "product_id"
    t.string   "name"
    t.string   "description"
    t.integer  "amount"
    t.integer  "qty"
    t.boolean  "automatic"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "costs", ["product_id"], name: "index_costs_on_product_id", using: :btree

  create_table "estimates", force: true do |t|
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "estimates", ["event_id"], name: "index_estimates_on_event_id", using: :btree

  create_table "estimates_products", id: false, force: true do |t|
    t.integer "estimate_id", null: false
    t.integer "product_id",  null: false
  end

  create_table "events", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lead_id"
    t.datetime "date"
  end

  add_index "events", ["lead_id"], name: "index_events_on_lead_id", using: :btree

  create_table "leads", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone_number"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "leads", ["company_id"], name: "index_leads_on_company_id", using: :btree

  create_table "line_items", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "amount"
    t.integer  "qty",         default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "estimate_id"
    t.string   "role"
  end

  add_index "line_items", ["estimate_id"], name: "index_line_items_on_estimate_id", using: :btree

  create_table "notes", force: true do |t|
    t.string   "body"
    t.integer  "lead_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notes", ["lead_id"], name: "index_notes_on_lead_id", using: :btree

  create_table "products", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "price"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "products", ["company_id"], name: "index_products_on_company_id", using: :btree

  create_table "timeline_categories", force: true do |t|
    t.string   "name"
    t.integer  "timeline_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "timeline_categories", ["timeline_id"], name: "index_timeline_categories_on_timeline_id", using: :btree

  create_table "timeline_events", force: true do |t|
    t.integer  "timeline_category_id"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "timeline_events", ["timeline_category_id"], name: "index_timeline_events_on_timeline_category_id", using: :btree

  create_table "timelines", force: true do |t|
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "timelines", ["event_id"], name: "index_timelines_on_event_id", using: :btree

  create_table "uploads", force: true do |t|
    t.string   "path"
    t.integer  "size",       limit: 8
    t.string   "name"
    t.string   "mime_type"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "uploads", ["event_id"], name: "index_uploads_on_event_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "authentication_token"
    t.integer  "company_id"
    t.string   "password_digest",        default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
  end

  add_index "users", ["company_id"], name: "index_users_on_company_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
