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

ActiveRecord::Schema.define(version: 109) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.string "email"
    t.string "crypted_password"
    t.string "role"
    t.integer "merchant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "shop_id"
    t.integer "role_id"
  end

  create_table "activities", force: :cascade do |t|
    t.json "image"
    t.string "title"
    t.string "content"
    t.integer "merchant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "addresses", force: :cascade do |t|
    t.integer "customer_id"
    t.string "province"
    t.string "city"
    t.string "district"
    t.string "address"
    t.string "name"
    t.string "mobile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "agent_changes", force: :cascade do |t|
    t.string "content"
    t.integer "status"
    t.integer "customer_id"
    t.integer "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "old_agent_id"
    t.integer "merchant_id"
  end

  create_table "answer_likes", force: :cascade do |t|
    t.integer "answer_id"
    t.integer "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "answers", force: :cascade do |t|
    t.integer "question_id"
    t.string "content"
    t.json "images"
    t.json "audio"
    t.integer "customer_id"
    t.integer "account_id"
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

  create_table "car_model_skus", force: :cascade do |t|
    t.integer "car_model_id"
    t.integer "t_sku_id"
    t.integer "t_category_id"
    t.integer "merchant_id"
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
    t.integer "t_spu_id"
    t.integer "customer_id"
  end

  create_table "coupon_logs", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "coupon_receive_id"
    t.integer "order_id"
    t.decimal "order_original_amount", precision: 10, scale: 2
    t.decimal "coupon_amount", precision: 10, scale: 2
    t.decimal "order_final_amount", precision: 10, scale: 2
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "coupon_receives", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "coupon_id"
    t.decimal "coupon_money", precision: 10, scale: 2
    t.decimal "full_money", precision: 10, scale: 2
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "discount", precision: 10, scale: 2
  end

  create_table "coupons", force: :cascade do |t|
    t.string "title"
    t.integer "ctype"
    t.integer "merchant_id"
    t.integer "created_by"
    t.datetime "begin_time"
    t.datetime "end_time"
    t.decimal "money", precision: 10, scale: 2
    t.integer "status"
    t.string "remarks"
    t.decimal "full_money", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "discount", precision: 10, scale: 2
    t.integer "max_num"
    t.jsonb "spus"
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
    t.jsonb "wechat_info"
    t.jsonb "location_info"
    t.jsonb "his_location_info"
    t.string "email"
    t.json "wx_barcode"
    t.integer "role_id"
    t.integer "dist_share_id"
    t.integer "dist_agent_id"
    t.integer "app_status"
    t.json "avatar"
    t.integer "merchant_id"
  end

  create_table "discounts", force: :cascade do |t|
    t.string "order_no"
    t.string "discount_reason"
    t.decimal "discount_amount", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dist_orders", force: :cascade do |t|
    t.integer "order_id"
    t.integer "dist_agent_id"
    t.string "sku_info"
    t.integer "customer_id"
    t.integer "merchant_id"
    t.decimal "pay_amount", precision: 10, scale: 2
    t.decimal "commission", precision: 10, scale: 2
    t.datetime "pay_time"
    t.datetime "complete_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dist_settings", force: :cascade do |t|
    t.integer "merchant_id"
    t.boolean "dist_switch"
    t.decimal "amount_limit", precision: 10, scale: 2
    t.integer "number_limit"
    t.decimal "sales_percent", precision: 10, scale: 2
    t.decimal "dist_percent", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dist_shares", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "parent_id"
    t.integer "activity_id"
    t.integer "coupon_id"
    t.integer "sku_id"
    t.integer "merchant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "merchant_id"
    t.integer "customer_id"
    t.integer "t_sku_id"
    t.decimal "price", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "group_buyers", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "group_id"
    t.integer "order_id"
    t.integer "t_sku_id"
    t.integer "group_quantity"
    t.integer "status"
    t.decimal "group_price", precision: 10, scale: 2
    t.decimal "group_amount", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string "title"
    t.string "detail"
    t.integer "merchant_id"
    t.integer "created_by"
    t.decimal "group_price", precision: 10, scale: 2
    t.integer "status"
    t.integer "t_sku_id"
    t.jsonb "sku_info"
    t.datetime "begin_time"
    t.datetime "end_time"
    t.integer "min_num"
    t.integer "max_num"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "labels", force: :cascade do |t|
    t.string "name"
    t.integer "ltype"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "image"
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
    t.integer "quantity"
    t.decimal "price", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "service_fee"
    t.integer "lack_quantity", default: 0
    t.integer "t_sku_id"
    t.integer "comment_status", default: 0
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
    t.datetime "delivere_time"
    t.integer "dist_share_id"
    t.integer "dist_agent_id"
    t.decimal "old_pay_amount", precision: 10, scale: 2
    t.decimal "refund_amount", precision: 10, scale: 2
    t.string "reject_reason"
  end

  create_table "page_views", force: :cascade do |t|
    t.integer "customer_id"
    t.datetime "visit_time"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "purchase_skus", force: :cascade do |t|
    t.integer "purchase_id"
    t.integer "t_sku_id"
    t.integer "current_stock"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "purchases", force: :cascade do |t|
    t.string "purchase_no"
    t.string "summary"
    t.jsonb "code_info"
    t.integer "merchant_id"
    t.integer "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string "content"
    t.integer "merchant_id"
    t.integer "customer_id"
    t.integer "topic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "t_sku_id"
    t.json "images"
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

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role_type"
  end

  create_table "seckill_buyers", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "seckill_id"
    t.integer "order_id"
    t.integer "t_sku_id"
    t.integer "status"
    t.integer "seckill_price"
    t.integer "seckill_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "seckills", force: :cascade do |t|
    t.string "title"
    t.string "detail"
    t.integer "merchant_id"
    t.integer "created_by"
    t.integer "t_sku_id"
    t.jsonb "sku_info"
    t.integer "num"
    t.integer "status"
    t.datetime "begin_time"
    t.datetime "end_time"
    t.decimal "seckill_price", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "remaining_num"
  end

  create_table "shares", force: :cascade do |t|
    t.integer "customer_id"
    t.string "url"
    t.jsonb "options"
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

  create_table "sku_views", force: :cascade do |t|
    t.integer "customer_id"
    t.datetime "visit_time"
    t.string "t_sku_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sub_orders", force: :cascade do |t|
    t.integer "order_id"
    t.string "sub_type"
    t.jsonb "order_sku_ids"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
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
    t.boolean "is_hidden", default: false
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
    t.jsonb "detail"
    t.integer "available_num"
    t.integer "preferred", default: 0
    t.string "preferred_slogan"
    t.integer "label_id"
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
    t.decimal "dist_percent", precision: 10, scale: 2
    t.json "details"
  end

  create_table "topics", force: :cascade do |t|
    t.string "title"
    t.integer "merchant_id"
    t.integer "created_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "withdraws", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "merchant_id"
    t.datetime "app_date"
    t.decimal "amount", precision: 10, scale: 2
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "pay_date"
    t.string "account_no"
    t.string "wechat_no"
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
