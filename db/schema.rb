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

ActiveRecord::Schema[7.0].define(version: 2022_04_13_064917) do
  create_table "histories", force: :cascade do |t|
    t.integer "tracking_id", null: false
    t.text "description"
    t.string "icon"
    t.datetime "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tracking_id"], name: "index_histories_on_tracking_id"
  end

  create_table "trackings", force: :cascade do |t|
    t.string "tracking_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "histories", "trackings"
end
