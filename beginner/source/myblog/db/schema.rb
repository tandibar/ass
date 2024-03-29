# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 10) do

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "image_url"
    t.string   "image_name"
    t.datetime "created_at"
    t.integer  "user_id"
  end

  create_table "articles_tags", :id => false, :force => true do |t|
    t.integer "article_id", :default => 0, :null => false
    t.integer "tag_id",     :default => 0, :null => false
  end

  create_table "comments", :force => true do |t|
    t.string   "author"
    t.string   "email"
    t.string   "content"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "password"
    t.datetime "created_at"
    t.string   "salt"
  end

end
