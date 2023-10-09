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

ActiveRecord::Schema[7.0].define(version: 2023_10_02_212755) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "geonames_data", force: :cascade do |t|
    t.string "name"
    t.string "country", limit: 2
    t.string "admin1", limit: 20
    t.string "admin2", limit: 80
    t.string "admin3", limit: 20
    t.string "admin4", limit: 20
    t.float "latitude"
    t.float "longitude"
    t.integer "population"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_geonames_data_on_name"
    t.index ["population"], name: "index_geonames_data_on_population"
  end

  create_table "subscribers", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
