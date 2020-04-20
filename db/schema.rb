# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_20_020908) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "discord_users", primary_key: "uid", force: :cascade do |t|
    t.string "name"
    t.string "discriminator"
    t.string "avatar_url"
    t.boolean "bot_account"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "events", force: :cascade do |t|
    t.string "type", null: false
    t.jsonb "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "invite_discord_users", force: :cascade do |t|
    t.bigint "invite_id"
    t.bigint "discord_user_uid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["invite_id", "discord_user_uid"], name: "index_invite_discord_users_on_invite_id_and_discord_user_uid", unique: true
  end

  create_table "invites", force: :cascade do |t|
    t.bigint "server_uid", null: false
    t.bigint "inviter_uid", null: false
    t.bigint "deleter_uid"
    t.string "code", null: false
    t.string "channel_uid", null: false
    t.integer "uses", null: false
    t.integer "max_uses"
    t.boolean "active", null: false
    t.boolean "temporary", null: false
    t.datetime "expires"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "quotes", force: :cascade do |t|
    t.bigint "server_uid"
    t.bigint "quoter_uid"
    t.bigint "quotee_uid"
    t.string "quote"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "message_id"
  end

  create_table "servers", force: :cascade do |t|
    t.bigint "uid", null: false
    t.string "name", null: false
    t.string "icon_id", null: false
    t.bigint "owner_uid", null: false
    t.string "region_id", null: false
    t.bigint "afk_channel_uid"
    t.bigint "system_channel_uid"
    t.boolean "large", null: false
    t.bigint "afk_timeout"
    t.string "verification_level", null: false
    t.bigint "member_count", null: false
    t.datetime "creation_time", null: false
    t.boolean "bot_active", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "temporary_voice_channels", force: :cascade do |t|
    t.bigint "server_uid", null: false
    t.bigint "creator_uid", null: false
    t.bigint "channel_uid", null: false
    t.boolean "is_jump_channel", null: false
    t.boolean "active", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "discord_uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
