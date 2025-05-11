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

ActiveRecord::Schema[7.2].define(version: 2025_04_23_161028) do
  create_table "mobiles", force: :cascade do |t|
    t.string "brand", null: false
    t.string "model", null: false
    t.date "release_date"
    t.string "display_size"
    t.string "resolution"
    t.string "processor"
    t.string "ram"
    t.string "storage"
    t.string "camera_main"
    t.string "camera_front"
    t.string "battery"
    t.string "os_version"
    t.string "price"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scrapers", force: :cascade do |t|
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
