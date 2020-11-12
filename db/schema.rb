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

ActiveRecord::Schema.define(version: 2020_11_12_064134) do

  create_table "accounts", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "nick_name"
    t.string "email"
    t.string "phone"
    t.string "address"
    t.string "city"
    t.string "postal"
    t.integer "province_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["province_id"], name: "index_accounts_on_province_id"
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "developers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "games", force: :cascade do |t|
    t.integer "sku"
    t.string "name"
    t.text "description"
    t.date "release_date"
    t.string "rating"
    t.decimal "price"
    t.integer "stock"
    t.string "link"
    t.string "cover"
    t.integer "developer_id", null: false
    t.integer "publisher_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["developer_id"], name: "index_games_on_developer_id"
    t.index ["publisher_id"], name: "index_games_on_publisher_id"
  end

  create_table "genre_games", force: :cascade do |t|
    t.integer "genre_id", null: false
    t.integer "game_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_genre_games_on_game_id"
    t.index ["genre_id"], name: "index_genre_games_on_genre_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "order_games", force: :cascade do |t|
    t.decimal "price"
    t.integer "sku"
    t.integer "qty"
    t.float "pst"
    t.float "gst"
    t.integer "order_id", null: false
    t.integer "game_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_order_games_on_game_id"
    t.index ["order_id"], name: "index_order_games_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "order_date"
    t.decimal "order_amount"
    t.string "order_status"
    t.string "shipping_address"
    t.string "shipping_city"
    t.string "shipping_province"
    t.string "shipping_postal"
    t.integer "account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_orders_on_account_id"
  end

  create_table "platform_games", force: :cascade do |t|
    t.integer "platform_id", null: false
    t.integer "game_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_platform_games_on_game_id"
    t.index ["platform_id"], name: "index_platform_games_on_platform_id"
  end

  create_table "platforms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "provinces", force: :cascade do |t|
    t.string "name"
    t.float "pst"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "publishers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "login"
    t.string "password"
    t.boolean "admin"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "accounts", "provinces"
  add_foreign_key "accounts", "users"
  add_foreign_key "games", "developers"
  add_foreign_key "games", "publishers"
  add_foreign_key "genre_games", "games"
  add_foreign_key "genre_games", "genres"
  add_foreign_key "order_games", "games"
  add_foreign_key "order_games", "orders"
  add_foreign_key "orders", "accounts"
  add_foreign_key "platform_games", "games"
  add_foreign_key "platform_games", "platforms"
end