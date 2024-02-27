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

ActiveRecord::Schema[7.0].define(version: 2024_01_09_035107) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "download_exceptions", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.text "exception_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_download_exceptions_on_recipe_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "ingredient"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "raw_ingredients", force: :cascade do |t|
    t.string "ingredient_name"
    t.bigint "ingredient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_raw_ingredients_on_ingredient_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.bigint "site_identifier_id", null: false
    t.string "title"
    t.text "about"
    t.text "url"
    t.text "page_url"
    t.text "ingredients"
    t.text "steps"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "main_photo"
    t.string "second_photo"
    t.string "video_link"
    t.string "encoded_url"
    t.text "parsed_ingredients"
    t.string "slug"
    t.index ["site_identifier_id"], name: "index_recipes_on_site_identifier_id"
    t.index ["slug"], name: "index_recipes_on_slug", unique: true
  end

  create_table "site_identifiers", force: :cascade do |t|
    t.string "title"
    t.string "identifier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.text "private_api_key_ciphertext"
    t.string "private_api_key_bidx"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["private_api_key_bidx"], name: "index_users_on_private_api_key_bidx", unique: true
  end

  add_foreign_key "download_exceptions", "recipes"
  add_foreign_key "raw_ingredients", "ingredients"
  add_foreign_key "recipes", "site_identifiers"
end
