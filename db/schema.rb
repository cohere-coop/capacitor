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

ActiveRecord::Schema.define(version: 20150509203039) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "username"
  end

  add_index "accounts", ["email"], name: "index_accounts_on_email", unique: true, using: :btree
  add_index "accounts", ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true, using: :btree

  create_table "capacities", force: :cascade do |t|
    t.integer  "amount"
    t.integer  "quality"
    t.date     "worked_at"
    t.integer  "project_id"
    t.integer  "worker_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.boolean  "do_not_bill"
  end

  add_index "capacities", ["project_id"], name: "index_capacities_on_project_id", using: :btree
  add_index "capacities", ["worker_id"], name: "index_capacities_on_worker_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.integer  "client_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.float    "total_capacity_owed"
  end

  add_index "projects", ["client_id"], name: "index_projects_on_client_id", using: :btree

  add_foreign_key "capacities", "accounts", column: "worker_id"
  add_foreign_key "capacities", "projects"
  add_foreign_key "projects", "accounts", column: "client_id"
end
