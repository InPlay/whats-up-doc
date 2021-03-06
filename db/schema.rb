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

ActiveRecord::Schema.define(version: 20160707192019) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "doc_items", force: :cascade do |t|
    t.integer  "doc_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "doc_list_positions", force: :cascade do |t|
    t.integer "item_id"
    t.integer "list_id"
    t.integer "position", default: -1
  end

  create_table "doc_lists", force: :cascade do |t|
    t.string "title"
    t.string "max_in_words"
    t.string "min_in_words"
  end

  create_table "docs", force: :cascade do |t|
    t.string   "title"
    t.string   "slug"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "impact_list_id"
    t.integer  "implementation_list_id"
  end

end
