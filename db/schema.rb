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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130326142216) do

  create_table "achievements", :force => true do |t|
    t.integer  "user_id"
    t.integer  "star_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "sender_id"
    t.integer  "receiver"
    t.string   "message"
  end

  create_table "requirements", :force => true do |t|
    t.string   "description"
    t.integer  "star_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "stars", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "type"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "treehouse_username"
    t.string   "codeschool_username"
    t.string   "blog_url"
    t.string   "profile_pic"
    t.string   "email"
    t.string   "github_username"
    t.integer  "giftable_star_bank"
    t.string   "password_digest"
    t.integer  "blog_count"
  end

end
