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

ActiveRecord::Schema[7.0].define(version: 2022_05_26_010621) do
  create_table "ach_transactions", force: :cascade do |t|
    t.string "account_number", null: false
    t.string "routing_number", null: false
    t.date "billing_date", null: false
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "merchant_id"
    t.index ["billing_date"], name: "index_ach_transactions_on_billing_date"
    t.index ["merchant_id"], name: "index_ach_transactions_on_merchant_id"
  end

  create_table "cc_transactions", force: :cascade do |t|
    t.string "card_number", null: false
    t.string "expiry_month", null: false
    t.string "expiry_year", null: false
    t.string "cvv", null: false
    t.string "zip", null: false
    t.date "billing_date", null: false
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "merchant_id"
    t.index ["billing_date"], name: "index_cc_transactions_on_billing_date"
    t.index ["merchant_id"], name: "index_cc_transactions_on_merchant_id"
  end

  create_table "merchants", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payouts", force: :cascade do |t|
    t.date "billing_date", null: false
    t.decimal "gross_cc_amount", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "cc_fees", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "net_cc_amount", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "gross_ach_amount", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "ach_fees", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "net_ach_amount", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "total_gross", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "total_fees", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "total_net", precision: 10, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "merchant_id"
    t.index ["billing_date"], name: "index_payouts_on_billing_date"
    t.index ["merchant_id"], name: "index_payouts_on_merchant_id"
  end

  add_foreign_key "ach_transactions", "merchants"
  add_foreign_key "cc_transactions", "merchants"
  add_foreign_key "payouts", "merchants"
end
