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

ActiveRecord::Schema.define(version: 4) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "car_brands", force: :cascade do |t|
    t.string "brand"
    t.jsonb "models"
    t.string "abc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "car_model_details", force: :cascade do |t|
    t.integer "car_model_id"
    t.string "energy_type"
    t.string "engine_capacity"
    t.string "intake_type"
    t.string "engine_max_power"
    t.string "engine_max_torque"
    t.string "battery_type"
    t.string "battery_energy"
    t.string "motor_max_power"
    t.string "motor_max_torque"
    t.string "gearbox"
    t.integer "length"
    t.integer "width"
    t.integer "height"
    t.integer "weight"
    t.string "front_tire_size"
    t.string "rear_tire_size"
    t.string "wheel_hub_spec"
    t.jsonb "engine_oil_label"
    t.decimal "max_engine_oil_volume", precision: 8, scale: 2
    t.jsonb "brake_fluid_label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "car_models", force: :cascade do |t|
    t.integer "car_year_id"
    t.string "car_model_name"
    t.string "car_model_version"
    t.string "car_model_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "car_years", force: :cascade do |t|
    t.string "brand"
    t.string "models"
    t.string "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
