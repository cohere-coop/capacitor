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

ActiveRecord::Schema.define(version: 20160223213720) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "accounts", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name",                                 default: "",                   null: false
    t.string   "email",                                default: "",                   null: false
    t.uuid     "uuid",                                 default: "uuid_generate_v4()"
    t.string   "encrypted_password",                                                  null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        default: 0,                    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                                          null: false
    t.datetime "updated_at",                                                          null: false
    t.integer  "weekly_expected_capacity",             default: 0,                    null: false
    t.string   "time_zone",                limit: 255, default: "UTC",                null: false
  end

  add_index "accounts", ["created_at"], name: "index_accounts_on_created_at", using: :btree
  add_index "accounts", ["current_sign_in_at"], name: "index_accounts_on_current_sign_in_at", using: :btree
  add_index "accounts", ["email"], name: "index_accounts_on_email", unique: true, using: :btree
  add_index "accounts", ["last_sign_in_at"], name: "index_accounts_on_last_sign_in_at", using: :btree
  add_index "accounts", ["remember_created_at"], name: "index_accounts_on_remember_created_at", using: :btree
  add_index "accounts", ["reset_password_sent_at"], name: "index_accounts_on_reset_password_sent_at", using: :btree
  add_index "accounts", ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true, using: :btree
  add_index "accounts", ["updated_at"], name: "index_accounts_on_updated_at", using: :btree

  create_table "checkins", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "log_counts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "logs", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "amount",      default: 0,     null: false
    t.integer  "quality",                     null: false
    t.boolean  "do_not_bill", default: false, null: false
    t.uuid     "project_id",                  null: false
    t.uuid     "account_id",                  null: false
    t.date     "worked_at",                   null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.text     "notes"
  end

  add_index "logs", ["account_id"], name: "index_logs_on_account_id", using: :btree
  add_index "logs", ["amount"], name: "index_logs_on_amount", using: :btree
  add_index "logs", ["created_at"], name: "index_logs_on_created_at", using: :btree
  add_index "logs", ["project_id"], name: "index_logs_on_project_id", using: :btree
  add_index "logs", ["quality"], name: "index_logs_on_quality", using: :btree
  add_index "logs", ["updated_at"], name: "index_logs_on_updated_at", using: :btree
  add_index "logs", ["worked_at"], name: "index_logs_on_worked_at", using: :btree

  create_table "memberships", force: :cascade do |t|
    t.uuid   "team_id",                       null: false
    t.uuid   "account_id",                    null: false
    t.string "level",      default: "member", null: false
  end

  add_index "memberships", ["account_id"], name: "index_memberships_on_account_id", using: :btree
  add_index "memberships", ["team_id"], name: "index_memberships_on_team_id", using: :btree

  create_table "projects", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name",             default: "",   null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "capacity",         default: 0,    null: false
    t.integer  "weekly_burn_rate", default: 0,    null: false
    t.boolean  "billable",         default: true, null: false
    t.boolean  "active",           default: true, null: false
  end

  add_index "projects", ["capacity"], name: "index_projects_on_capacity", using: :btree
  add_index "projects", ["created_at"], name: "index_projects_on_created_at", using: :btree
  add_index "projects", ["name"], name: "index_projects_on_name", using: :btree
  add_index "projects", ["updated_at"], name: "index_projects_on_updated_at", using: :btree

  create_table "teams", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name",       default: "", null: false
    t.uuid     "leader_id",               null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "teams", ["leader_id"], name: "index_teams_on_leader_id", using: :btree
  add_index "teams", ["name"], name: "index_teams_on_name", using: :btree

  create_table "teams_projects", force: :cascade do |t|
    t.uuid     "team_id",    null: false
    t.uuid     "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "teams_projects", ["project_id"], name: "index_teams_projects_on_project_id", using: :btree
  add_index "teams_projects", ["team_id"], name: "index_teams_projects_on_team_id", using: :btree

end
