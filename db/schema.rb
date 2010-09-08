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

ActiveRecord::Schema.define(:version => 20100908105457) do

  create_table "cinemas", :force => true do |t|
    t.string "name"
    t.string "city"
  end

  create_table "favourite_cinemas", :force => true do |t|
    t.integer "user_id"
    t.integer "cinema_id"
  end

  add_index "favourite_cinemas", ["cinema_id"], :name => "index_favourite_cinemas_on_cinema_id"
  add_index "favourite_cinemas", ["user_id"], :name => "index_favourite_cinemas_on_user_id"

  create_table "movie_visits", :force => true do |t|
    t.integer  "user_id"
    t.integer  "movie_id"
    t.integer  "cinema_id"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "movie_visits", ["cinema_id"], :name => "index_movie_visits_on_cinema_id"
  add_index "movie_visits", ["movie_id"], :name => "index_movie_visits_on_movie_id"
  add_index "movie_visits", ["user_id"], :name => "index_movie_visits_on_user_id"

  create_table "movies", :force => true do |t|
    t.string  "name"
    t.string  "english_name"
    t.string  "genre"
    t.string  "country"
    t.integer "year"
    t.integer "duration"
    t.string  "afisha_link"
    t.integer "shows_count"
    t.string  "image_url"
  end

  create_table "shows", :force => true do |t|
    t.integer  "cinema_id"
    t.integer  "movie_id"
    t.datetime "time"
  end

  add_index "shows", ["cinema_id"], :name => "index_shows_on_cinema_id"
  add_index "shows", ["movie_id", "time"], :name => "index_shows_on_movie_id_and_time"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
