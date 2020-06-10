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

ActiveRecord::Schema.define(version: 32) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  create_table "comments", force: :cascade do |t|
    t.integer "order_id"
    t.integer "t_sku_id"
    t.json "images"
    t.integer "rating"
    t.string "content"
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
    t.decimal "discount_amount", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "levels", force: :cascade do |t|
    t.string "level_name"
    t.integer "discount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "merchants", force: :cascade do |t|
    t.string "name"
    t.string "appid"
    t.string "appsecret"
    t.string "mch_id"
    t.string "mch_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_reservations", force: :cascade do |t|
    t.integer "shop_id"
    t.string "order_no"
    t.date "booking_date"
    t.datetime "booking_time_from"
    t.datetime "booking_time_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_skus", force: :cascade do |t|
    t.string "order_no"
    t.string "name"
    t.string "t_sku_id"
    t.integer "quantity"
    t.decimal "price", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "service_fee"
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
    t.integer "shop_id"
    t.jsonb "delivery_info"
    t.jsonb "contact_info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recommends", force: :cascade do |t|
    t.string "name"
    t.string "rtype"
    t.integer "t_category_id"
    t.integer "t_spu_id"
    t.integer "t_sku_id"
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

  create_table "t_attributes", force: :cascade do |t|
    t.integer "t_category_id"
    t.string "name"
    t.boolean "numeric"
    t.boolean "generic"
    t.boolean "selling"
    t.boolean "searching"
    t.string "unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "t_attrvalues", force: :cascade do |t|
    t.integer "t_category_id"
    t.integer "t_attribute_id"
    t.string "value"
    t.boolean "is_valid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "t_brands", force: :cascade do |t|
    t.string "name"
    t.string "detail"
    t.string "image"
    t.string "letter"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "t_categories", force: :cascade do |t|
    t.string "name"
    t.integer "parent_id"
    t.boolean "if_parent"
    t.integer "sort"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "t_category_brands", force: :cascade do |t|
    t.integer "t_category_id"
    t.integer "t_brand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "t_skus", force: :cascade do |t|
    t.integer "t_spu_id"
    t.integer "merchant_id"
    t.string "sku_code"
    t.string "title"
    t.json "images"
    t.decimal "price", precision: 10, scale: 2
    t.jsonb "sale_attrs"
    t.jsonb "attrs"
    t.boolean "saleable"
    t.boolean "is_valid"
    t.integer "stock_num"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "service_fee"
  end

  create_table "t_spus", force: :cascade do |t|
    t.integer "t_category_id"
    t.integer "t_brand_id"
    t.integer "merchant_id"
    t.string "title"
    t.string "detail"
    t.boolean "saleable"
    t.boolean "is_valid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "working_time_sets", force: :cascade do |t|
    t.integer "shop_id"
    t.integer "t_category_id"
    t.decimal "hours", precision: 10, scale: 2
    t.boolean "need_lift"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wxpay_infos", force: :cascade do |t|
    t.string "prepay_id"
    t.integer "customer_id"
    t.string "order_no"
    t.datetime "expired_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "pay_detail"
    t.string "transaction_id"
    t.datetime "pay_time"
    t.string "status"
    t.decimal "amount", precision: 10, scale: 2
  end

end
