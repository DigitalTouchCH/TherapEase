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

ActiveRecord::Schema[7.0].define(version: 2023_09_18_191528) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "absences", force: :cascade do |t|
    t.string "reason"
    t.bigint "therapist_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.index ["therapist_id"], name: "index_absences_on_therapist_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "bookings", force: :cascade do |t|
    t.string "status"
    t.text "info_public"
    t.text "info_private"
    t.bigint "patient_id", null: false
    t.bigint "meeting_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meeting_id"], name: "index_bookings_on_meeting_id"
    t.index ["patient_id"], name: "index_bookings_on_patient_id"
  end

  create_table "media", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "url"
    t.bigint "therapist_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["therapist_id"], name: "index_media_on_therapist_id"
  end

  create_table "media_meetings", force: :cascade do |t|
    t.text "info_public"
    t.text "info_private"
    t.bigint "medium_id", null: false
    t.bigint "meeting_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["medium_id"], name: "index_media_meetings_on_medium_id"
    t.index ["meeting_id"], name: "index_media_meetings_on_meeting_id"
  end

  create_table "meetings", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.text "info_public"
    t.text "info_private"
    t.string "url_zoom"
    t.integer "max_attendees"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "package_id", null: false
    t.index ["package_id"], name: "index_meetings_on_package_id"
  end

  create_table "packages", force: :cascade do |t|
    t.integer "num_of_session"
    t.text "info_private"
    t.text "info_public"
    t.string "insurance_name"
    t.string "insurance_number"
    t.string "insurance_type"
    t.string "package_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "service_id", null: false
    t.bigint "therapist_id", null: false
    t.bigint "patient_id", null: false
    t.index ["patient_id"], name: "index_packages_on_patient_id"
    t.index ["service_id"], name: "index_packages_on_service_id"
    t.index ["therapist_id"], name: "index_packages_on_therapist_id"
  end

  create_table "patients", force: :cascade do |t|
    t.date "date_of_birth"
    t.integer "age"
    t.string "addresse"
    t.string "tel_1"
    t.string "tel_2"
    t.string "contact_name"
    t.string "contact_info"
    t.string "contact_tel"
    t.string "info_private"
    t.string "info_public"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["user_id"], name: "index_patients_on_user_id", unique: true
  end

  create_table "services", force: :cascade do |t|
    t.boolean "active"
    t.string "name"
    t.string "paiement_methode"
    t.boolean "insurance_visibility"
    t.string "place_type"
    t.boolean "price_visibility"
    t.decimal "price_per_unit"
    t.integer "duration_per_unit"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "services_therapists", id: false, force: :cascade do |t|
    t.bigint "therapist_id", null: false
    t.bigint "service_id", null: false
  end

  create_table "therapists", force: :cascade do |t|
    t.text "information"
    t.string "location_name"
    t.string "location_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["user_id"], name: "index_therapists_on_user_id", unique: true
  end

  create_table "time_blocks", force: :cascade do |t|
    t.string "week_day"
    t.time "start_time"
    t.time "end_time"
    t.bigint "week_availability_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["week_availability_id"], name: "index_time_blocks_on_week_availability_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "week_availabilities", force: :cascade do |t|
    t.date "valid_from"
    t.date "valid_until"
    t.string "name"
    t.bigint "therapist_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["therapist_id"], name: "index_week_availabilities_on_therapist_id"
  end

  add_foreign_key "absences", "therapists"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bookings", "meetings"
  add_foreign_key "bookings", "patients"
  add_foreign_key "media", "therapists"
  add_foreign_key "media_meetings", "media"
  add_foreign_key "media_meetings", "meetings"
  add_foreign_key "meetings", "packages"
  add_foreign_key "packages", "patients"
  add_foreign_key "packages", "services"
  add_foreign_key "packages", "therapists"
  add_foreign_key "patients", "users"
  add_foreign_key "therapists", "users"
  add_foreign_key "time_blocks", "week_availabilities"
  add_foreign_key "week_availabilities", "therapists"
end
