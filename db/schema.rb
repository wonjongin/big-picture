# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_02_17_055334) do
  create_table "communities", force: :cascade do |t|
    t.string "ocid"
    t.string "dp_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "communities_users", id: false, force: :cascade do |t|
    t.integer "community_id"
    t.integer "user_id"
    t.index ["community_id"], name: "index_communities_users_on_community_id"
    t.index ["user_id"], name: "index_communities_users_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.string "location"
    t.boolean "allday"
    t.datetime "start"
    t.datetime "end"
    t.integer "community_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["community_id"], name: "index_events_on_community_id"
  end

  create_table "events_users", id: false, force: :cascade do |t|
    t.integer "event_id"
    t.integer "user_id"
    t.index ["event_id"], name: "index_events_users_on_event_id"
    t.index ["user_id"], name: "index_events_users_on_user_id"
  end

  create_table "social_auths", force: :cascade do |t|
    t.string "provider", null: false
    t.string "uid", null: false
    t.string "given_name"
    t.string "family_name"
    t.string "email"
    t.string "photo"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_social_auths_on_user_id"
  end

  create_table "tokens", force: :cascade do |t|
    t.string "access_token"
    t.string "refresh_token"
    t.datetime "access_expired_at"
    t.datetime "refresh_expired_at"
    t.string "user_agent"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ip"
    t.index ["user_id"], name: "index_tokens_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "ouid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
