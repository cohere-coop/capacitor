class InitSchema < ActiveRecord::Migration
  def up
    enable_extension "plpgsql"
    enable_extension "uuid-ossp"

    create_table "accounts", id: :uuid do |t|
      t.string "name", null: false, default: ""
      t.string "username", null: false, default: "", index: { unique: true }
      t.string "email", default: "", null: false, index: { unique: true }
      t.uuid "uuid", null: false, default: "uuid_generate_v4()"
      t.string "encrypted_password", null: false
      t.string "reset_password_token", index: { unique: true }
      t.datetime "reset_password_sent_at", index: true
      t.datetime "remember_created_at", index: true
      t.integer "sign_in_count", default: 0, null: false
      t.datetime "current_sign_in_at", index: true
      t.datetime "last_sign_in_at", index: true
      t.inet "current_sign_in_ip"
      t.inet "last_sign_in_ip"
      t.datetime "created_at", null: false, index: true
      t.datetime "updated_at", null: false, index: true
    end

    create_table "logs", id: :uuid do |t|
      t.integer "amount", null: false, default: 0, index: true
      t.integer "quality", null: false, index: true
      t.boolean "do_not_bill", null: false, default: false
      t.uuid "project_id", null: false, index: true
      t.uuid "account_id", null: false, index: true
      t.date "worked_at", null: false, index: true
      t.datetime "created_at", null: false, index: true
      t.datetime "updated_at", null: false, index: true
    end

    create_table "projects", id: :uuid do |t|
      t.string "name", null: false, default: "", index: true
      t.datetime "created_at", null: false, index: true
      t.datetime "updated_at", null: false, index: true
      t.integer "capacity", null: false, default: 0, index: true
      t.integer "capacity_logged", null: false, default: 0, index: true
    end
  end

  def down
    raise "Can not revert initial migration"
  end
end
