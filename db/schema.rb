# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160127100402) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.string   "secret",     null: false
    t.string   "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books", force: :cascade do |t|
    t.integer  "uid"
    t.string   "isbn"
    t.string   "title"
    t.text     "link"
    t.text     "description"
    t.string   "average_rating"
    t.integer  "ratings_count"
    t.string   "image"
    t.integer  "publication_year"
    t.datetime "date_added"
    t.string   "author_name"
    t.string   "author_link"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "pages"
    t.index ["average_rating"], name: "index_books_on_average_rating", using: :btree
    t.index ["publication_year"], name: "index_books_on_publication_year", using: :btree
    t.index ["ratings_count"], name: "index_books_on_ratings_count", using: :btree
    t.index ["title"], name: "index_books_on_title", using: :btree
    t.index ["uid"], name: "index_books_on_uid", using: :btree
  end

end
