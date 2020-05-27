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

ActiveRecord::Schema.define(version: 23) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attributes", force: :cascade do |t|
    t.string "attr_name"
    t.string "attr_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "car_brands", force: :cascade do |t|
    t.string "brand"
    t.jsonb "models"
    t.string "abc"
    t.string "image_url"
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

  create_table "car_sku_mappings", force: :cascade do |t|
    t.string "sku_code"
    t.integer "car_year_id"
    t.integer "car_model_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "car_years", force: :cascade do |t|
    t.string "brand"
    t.string "car_model"
    t.string "manufacturer"
    t.string "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cars", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "car_model_id"
    t.string "car_model_name"
    t.datetime "license_date"
    t.string "color"
    t.integer "mileage"
    t.jsonb "mileage_his"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_current"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.integer "parent_id"
    t.string "cate_type"
    t.boolean "is_hidden"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "sex"
    t.string "mobile"
    t.datetime "birth"
    t.jsonb "address"
    t.string "openid"
    t.string "unionid"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "discounts", force: :cascade do |t|
    t.string "order_no"
    t.string "discount_reason"
    t.decimal "discount_amount", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "features", force: :cascade do |t|
    t.integer "category_id"
    t.string "name"
    t.string "description"
    t.string "feature_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "goods", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.json "pics"
    t.string "comment"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "goods_attributes", force: :cascade do |t|
    t.integer "goods_id"
    t.integer "attribute_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inventories", force: :cascade do |t|
    t.integer "merchant_id"
    t.string "sku_code"
    t.integer "num"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "merchants", force: :cascade do |t|
    t.string "name"
    t.string "password"
    t.string "email"
    t.string "mobile"
    t.string "appid"
    t.string "appsecret"
    t.string "mch_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_skus", force: :cascade do |t|
    t.string "order_no"
    t.string "name"
    t.string "sku_code"
    t.integer "quantity"
    t.decimal "price", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "merchant_id"
    t.datetime "order_date"
    t.string "order_no"
    t.decimal "amount", precision: 10, scale: 2
    t.string "order_name"
    t.string "order_type"
    t.decimal "pay_amount", precision: 10, scale: 2
    t.string "pay_way"
    t.datetime "pay_time"
    t.string "tx_num"
    t.string "status"
    t.datetime "cancel_time"
    t.string "cancel_reason"
    t.datetime "reservation_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recommends", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.integer "category_id"
    t.integer "goods_id"
    t.integer "sku_id"
    t.integer "car_year_id"
    t.integer "car_model_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "records", force: :cascade do |t|
    t.integer "car_id"
    t.string "order_no"
    t.datetime "record_date"
    t.string "order_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shops", force: :cascade do |t|
    t.integer "merchant_id"
    t.string "name"
    t.string "address"
    t.string "contact_name"
    t.string "contact_phone"
    t.jsonb "workstation"
    t.jsonb "business_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sku_attributes", force: :cascade do |t|
    t.string "sku_code"
    t.integer "attribute_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skus", force: :cascade do |t|
    t.integer "goods_id"
    t.string "sku_name"
    t.string "sku_code"
    t.decimal "price", precision: 8, scale: 2
    t.integer "stock_quantity"
    t.decimal "weight", precision: 8, scale: 2
    t.json "pics"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
