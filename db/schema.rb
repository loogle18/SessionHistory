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

ActiveRecord::Schema.define(version: 20171007174332) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "histories", force: :cascade do |t|
    t.integer "session_id", null: false
    t.string "started_by", null: false
    t.integer "summary_status", null: false
    t.float "duration"
    t.float "worker_time"
    t.integer "bundle_time"
    t.integer "num_workers"
    t.string "branch", null: false
    t.string "commit_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
