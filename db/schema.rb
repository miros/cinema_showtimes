# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100818110254) do

  create_table "cinemas", :force => true do |t|
    t.string "name"
    t.string "city"
  end

  create_table "favourite_cinemas", :force => true do |t|
    t.integer "user_id"
    t.integer "cinema_id"
  end

  create_table "movies", :force => true do |t|
    t.string  "name"
    t.string  "english_name"
    t.string  "genre"
    t.string  "country"
    t.integer "year"
    t.integer "duration"
    t.string  "afisha_link"
  end

  create_table "shows", :force => true do |t|
    t.integer  "cinema_id"
    t.integer  "movie_id"
    t.datetime "time"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
