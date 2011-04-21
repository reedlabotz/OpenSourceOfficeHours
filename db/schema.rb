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

ActiveRecord::Schema.define(:version => 20110421001948) do

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.string   "number"
    t.string   "department"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "office_hours", :force => true do |t|
    t.integer  "user_course_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "location"
    t.text     "location_details"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ratings", :force => true do |t|
    t.integer  "user_course_id"
    t.integer  "number"
    t.text     "comment"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_courses", :force => true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.string   "year"
    t.integer  "confidence"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "notes"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "activation_code"
    t.datetime "activated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
  end

end
