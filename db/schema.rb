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

ActiveRecord::Schema.define(version: 20181230194650) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"
  enable_extension "hstore"

  create_table "accounts", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "weekly_expected_capacity", default: 0, null: false
    t.string "time_zone", default: "Central Time (US & Canada)", null: false
    t.hstore "features"
    t.integer "check_in_reminder_hour", default: 8
    t.index ["created_at"], name: "index_accounts_on_created_at"
    t.index ["current_sign_in_at"], name: "index_accounts_on_current_sign_in_at"
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["last_sign_in_at"], name: "index_accounts_on_last_sign_in_at"
    t.index ["remember_created_at"], name: "index_accounts_on_remember_created_at"
    t.index ["reset_password_sent_at"], name: "index_accounts_on_reset_password_sent_at"
    t.index ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true
    t.index ["updated_at"], name: "index_accounts_on_updated_at"
  end

  create_table "activities", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "name", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "capacity", default: 0, null: false
    t.integer "weekly_burn_rate", default: 0, null: false
    t.boolean "billable", default: true, null: false
    t.boolean "active", default: true, null: false
    t.uuid "owner_id"
    t.index ["capacity"], name: "index_activities_on_capacity"
    t.index ["created_at"], name: "index_activities_on_created_at"
    t.index ["name"], name: "index_activities_on_name"
    t.index ["updated_at"], name: "index_activities_on_updated_at"
  end

  create_table "check_ins", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "account_id", null: false
    t.date "worked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "logs", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.integer "amount", default: 0, null: false
    t.integer "quality", null: false
    t.boolean "do_not_bill", default: false, null: false
    t.uuid "activity_id", null: false
    t.uuid "account_id", null: false
    t.date "worked_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "notes"
    t.uuid "check_in_id"
    t.index ["account_id"], name: "index_logs_on_account_id"
    t.index ["activity_id"], name: "index_logs_on_activity_id"
    t.index ["amount"], name: "index_logs_on_amount"
    t.index ["created_at"], name: "index_logs_on_created_at"
    t.index ["quality"], name: "index_logs_on_quality"
    t.index ["updated_at"], name: "index_logs_on_updated_at"
    t.index ["worked_at"], name: "index_logs_on_worked_at"
  end

  create_table "memberships", id: :serial, force: :cascade do |t|
    t.uuid "team_id", null: false
    t.uuid "account_id", null: false
    t.string "level", default: "member", null: false
    t.index ["account_id"], name: "index_memberships_on_account_id"
    t.index ["team_id"], name: "index_memberships_on_team_id"
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.uuid "resource_owner_id", null: false
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "scopes"
    t.index ["application_id"], name: "index_oauth_access_grants_on_application_id"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.uuid "resource_owner_id"
    t.bigint "application_id"
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "owner_id"
    t.string "owner_type"
    t.boolean "confidential", default: true, null: false
    t.index ["owner_id", "owner_type"], name: "index_oauth_applications_on_owner_id_and_owner_type"
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "teams", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "name", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_teams_on_name"
  end

  create_table "teams_activities", id: :serial, force: :cascade do |t|
    t.uuid "team_id", null: false
    t.uuid "activity_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_teams_activities_on_activity_id"
    t.index ["team_id"], name: "index_teams_activities_on_team_id"
  end

  add_foreign_key "oauth_access_grants", "accounts", column: "resource_owner_id"
  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "accounts", column: "resource_owner_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
end
