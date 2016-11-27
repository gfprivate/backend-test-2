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

ActiveRecord::Schema.define(version: 20161127120119) do

  create_table "calls", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "from"
    t.string   "to"
    t.string   "voicemail_url"
    t.string   "service"
    t.string   "service_call_id"
    t.string   "status"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "calls", ["service_call_id"], name: "index_calls_on_service_call_id"
  add_index "calls", ["user_id"], name: "index_calls_on_user_id"

  create_table "company_numbers", force: :cascade do |t|
    t.string   "sip_endpoint"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "phone_number"
  end

  add_index "company_numbers", ["phone_number"], name: "index_company_numbers_on_phone_number"

  create_table "company_numbers_assignees", id: false, force: :cascade do |t|
    t.integer "user_id",           null: false
    t.integer "company_number_id", null: false
    t.integer "order"
  end

  add_index "company_numbers_assignees", ["company_number_id", "order"], name: "index_company_numbers_assignees_number_order", unique: true
  add_index "company_numbers_assignees", ["user_id", "company_number_id"], name: "index_company_numbers_assignees_user_number", unique: true

  create_table "user_numbers", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "sip_endpoint"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "user_numbers", ["user_id"], name: "index_user_numbers_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
