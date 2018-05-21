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

ActiveRecord::Schema.define(version: 2018_05_21_123124) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "administrators", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_administrators_on_email", unique: true
    t.index ["reset_password_token"], name: "index_administrators_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_administrators_on_unlock_token", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "outcomes", force: :cascade do |t|
    t.integer "category_id", null: false
    t.string "name", null: false
    t.boolean "published", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_outcomes_on_category_id"
    t.index ["name"], name: "index_outcomes_on_name", unique: true
  end

  create_table "user_logs", force: :cascade do |t|
    t.date "target_date", null: false
    t.integer "male_10", default: 0, null: false
    t.integer "male_20", default: 0, null: false
    t.integer "male_30", default: 0, null: false
    t.integer "male_40", default: 0, null: false
    t.integer "male_50", default: 0, null: false
    t.integer "male_60", default: 0, null: false
    t.integer "female_10", default: 0, null: false
    t.integer "female_20", default: 0, null: false
    t.integer "female_30", default: 0, null: false
    t.integer "female_40", default: 0, null: false
    t.integer "female_50", default: 0, null: false
    t.integer "female_60", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["target_date"], name: "index_user_logs_on_target_date", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.integer "gender", null: false
    t.integer "year_of_birth", null: false
    t.integer "prefecture", null: false
    t.date "registered_at", null: false
    t.date "left_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gender"], name: "index_users_on_gender"
    t.index ["left_at"], name: "index_users_on_left_at"
    t.index ["prefecture"], name: "index_users_on_prefecture"
    t.index ["registered_at"], name: "index_users_on_registered_at"
    t.index ["year_of_birth"], name: "index_users_on_year_of_birth"
  end

  create_table "users_outcomes", force: :cascade do |t|
    t.date "post_date", null: false
    t.integer "post_time", null: false
    t.bigint "user_id", null: false
    t.bigint "outcome_id", null: false
    t.integer "reaction", null: false
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_date", "post_time", "user_id", "outcome_id"], name: "index_users_outcomes_on_post_time_and_user_and_outcome", unique: true
    t.index ["reaction"], name: "index_users_outcomes_on_reaction"
  end

end
