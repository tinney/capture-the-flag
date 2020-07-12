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

ActiveRecord::Schema.define(version: 2020_01_14_011432) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "moves", force: :cascade do |t|
    t.integer "player_id"
    t.integer "x_location"
    t.integer "y_location"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "players", force: :cascade do |t|
    t.integer "team_id"
    t.string "name"
    t.integer "water_stat", null: false
    t.integer "food_stat", null: false
    t.integer "stamina_stat", null: false
    t.integer "strength_stat", null: false
    t.boolean "active", default: true, null: false
    t.integer "days_active", default: 0, null: false
    t.integer "days_without_water", default: 0, null: false
    t.integer "days_without_food", default: 0, null: false
    t.integer "water_count", null: false
    t.integer "food_count", null: false
    t.integer "x_location", null: false
    t.integer "y_location", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "resources", force: :cascade do |t|
    t.integer "x_location", default: 0, null: false
    t.integer "y_location", default: 0, null: false
    t.integer "amount", default: 1, null: false
    t.boolean "active", default: true, null: false
    t.boolean "is_water", default: false, null: false
    t.boolean "is_food", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
