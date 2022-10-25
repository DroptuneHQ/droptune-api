# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_10_25_164122) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.bigint "artist_id", null: false
    t.string "name"
    t.date "release_date"
    t.string "album_type"
    t.text "spotify_id"
    t.text "spotify_image"
    t.text "spotify_link"
    t.bigint "applemusic_id"
    t.text "applemusic_image"
    t.text "applemusic_link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_albums_on_artist_id"
  end

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "music_videos", force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.date "release_date"
    t.string "source"
    t.string "source_data"
    t.bigint "artist_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_music_videos_on_artist_id"
  end

  create_table "sources", force: :cascade do |t|
    t.bigint "artist_id", null: false
    t.string "name"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_sources_on_artist_id"
  end

  add_foreign_key "albums", "artists"
  add_foreign_key "music_videos", "artists"
  add_foreign_key "sources", "artists"
end
