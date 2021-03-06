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

ActiveRecord::Schema.define(version: 20170805051348) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "concerts", force: :cascade do |t|
    t.string   "name"
    t.string   "venue"
    t.date     "concertdate"
    t.string   "conductor"
    t.string   "accompanist"
    t.text     "theme"
    t.text     "notes"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.decimal  "concert_year", precision: 6, scale: 2
    t.string   "narrators"
  end

  create_table "concerts_singers", id: false, force: :cascade do |t|
    t.integer "concert_id", null: false
    t.integer "singer_id",  null: false
  end

  create_table "concerts_songs", id: false, force: :cascade do |t|
    t.integer "concert_id", null: false
    t.integer "song_id",    null: false
  end

  create_table "pictures", force: :cascade do |t|
    t.text     "picture_data"
    t.string   "caption"
    t.date     "picture_date"
    t.text     "notes"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "submitted_by"
  end

  create_table "programs", force: :cascade do |t|
    t.integer  "concert_id",              comment: "concert id for given song"
    t.integer  "song_id",                 comment: "song id for given concert"
    t.integer  "song_order",              comment: "Stores the order of songs in this concert"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["concert_id"], name: "index_programs_on_concert_id", using: :btree
    t.index ["song_id"], name: "index_programs_on_songs_id", using: :btree
  end

  create_table "singers", force: :cascade do |t|
    t.string   "last_name"
    t.string   "first_name"
    t.string   "email"
    t.string   "voice"
    t.date     "joined"
    t.date     "left"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "join_year"
    t.integer  "left_year"
    t.text     "notes"
    t.text     "photo_data"
    t.text     "image_data"
    t.string   "photo1_caption"
    t.string   "photo2_caption"
  end

  create_table "singers_songs", id: false, force: :cascade do |t|
    t.integer "singer_id", null: false
    t.integer "song_id",   null: false
  end

  create_table "songs", force: :cascade do |t|
    t.string   "name"
    t.string   "source"
    t.string   "composer"
    t.string   "lyricist"
    t.string   "genre"
    t.string   "song_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "arranger"
    t.text     "notes"
    t.integer  "s_o"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "name"
    t.boolean  "member"
    t.boolean  "admin"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
