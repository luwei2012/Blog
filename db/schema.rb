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

ActiveRecord::Schema.define(version: 20160403085644) do

  create_table "albums", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.string   "album_name",  limit: 255
    t.integer  "words_count", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "articles", force: :cascade do |t|
    t.integer  "album_id",        limit: 4
    t.integer  "user_id",         limit: 4
    t.string   "title",           limit: 255
    t.string   "content",         limit: 255
    t.integer  "words_count",     limit: 4
    t.integer  "praised_count",   limit: 4
    t.integer  "collected_count", limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",           limit: 4
    t.integer  "article_id",        limit: 4
    t.integer  "parent_comment_id", limit: 4
    t.string   "content",           limit: 255
    t.integer  "praised_count",     limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "documents", force: :cascade do |t|
    t.integer  "user_id",          limit: 4
    t.integer  "article_id",       limit: 4
    t.integer  "document_type",    limit: 4
    t.integer  "status",           limit: 4
    t.string   "screenshot",       limit: 255
    t.string   "original",         limit: 255
    t.string   "title",            limit: 255
    t.string   "file_name",        limit: 255
    t.integer  "upload_file_size", limit: 4
    t.string   "content",          limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "role_name",  limit: 255
    t.integer  "authority",  limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "user_article_collections", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "article_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "user_article_praises", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "article_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "user_comment_praises", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "comment_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "user_icons", force: :cascade do |t|
    t.integer  "user_id",          limit: 4
    t.string   "screenshot",       limit: 255
    t.string   "original",         limit: 255
    t.string   "title",            limit: 255
    t.string   "file_name",        limit: 255
    t.integer  "upload_file_size", limit: 4
    t.string   "content",          limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer  "role_id",     limit: 4
    t.string   "user_name",   limit: 255
    t.string   "account",     limit: 255
    t.string   "password",    limit: 255
    t.string   "email",       limit: 255
    t.string   "introduce",   limit: 255
    t.integer  "words_count", limit: 4
    t.string   "auth_token"
    t.string   "password_digest"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

end
