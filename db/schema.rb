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

ActiveRecord::Schema.define(version: 20160420133041) do

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

  create_table "authentications_books", force: :cascade do |t|
    t.integer "book_id"
    t.integer "authentication_id"
  end

  add_index "authentications_books", ["authentication_id"], name: "index_authentications_books_on_authentication_id", using: :btree
  add_index "authentications_books", ["book_id"], name: "index_authentications_books_on_book_id", using: :btree

  create_table "book_changes", force: :cascade do |t|
    t.integer  "book_id",                     null: false
    t.string   "changed_field",               null: false
    t.float    "changed_value", default: 0.0
    t.datetime "changed_date"
  end

  add_index "book_changes", ["book_id"], name: "index_book_changes_on_book_id", using: :btree
  add_index "book_changes", ["changed_field"], name: "index_book_changes_on_changed_field", using: :btree
  add_index "book_changes", ["changed_value"], name: "index_book_changes_on_changed_value", using: :btree

  create_table "books", force: :cascade do |t|
    t.integer  "uid"
    t.string   "isbn"
    t.string   "title"
    t.text     "description"
    t.text     "link"
    t.string   "image"
    t.integer  "ratings_count",                default: 0
    t.integer  "pages",                        default: 0
    t.integer  "publication_year",             default: 0
    t.datetime "date_added"
    t.string   "author_name"
    t.string   "author_link"
    t.string   "language"
    t.string   "amazon_url",                   default: "0"
    t.float    "amazon_paper_price",           default: 0.0
    t.float    "amazon_kindle_price",          default: 0.0
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.float    "average_rating",               default: 0.0
    t.float    "previous_average_rating",      default: 0.0
    t.float    "previous_amazon_paper_price",  default: 0.0
    t.float    "previous_amazon_kindle_price", default: 0.0
  end

  add_index "books", ["amazon_kindle_price"], name: "index_books_on_amazon_kindle_price", using: :btree
  add_index "books", ["amazon_paper_price"], name: "index_books_on_amazon_paper_price", using: :btree
  add_index "books", ["pages"], name: "index_books_on_pages", using: :btree
  add_index "books", ["publication_year"], name: "index_books_on_publication_year", using: :btree
  add_index "books", ["ratings_count"], name: "index_books_on_ratings_count", using: :btree
  add_index "books", ["uid"], name: "index_books_on_uid", using: :btree

  add_foreign_key "authentications_books", "authentications"
  add_foreign_key "authentications_books", "books"
end
