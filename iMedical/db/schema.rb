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

ActiveRecord::Schema.define(version: 2018_10_28_175703) do

  create_table "clinics", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "owner_id"
    t.string "name"
    t.string "address"
    t.string "description"
    t.string "province"
    t.string "city"
    t.float "latitude"
    t.float "longitude"
    t.index ["owner_id"], name: "index_clinics_on_owner_id"
  end

  create_table "doctors", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "drugs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "examinations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "patient_id"
    t.integer "doctor_id"
    t.integer "clinic_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.index ["clinic_id"], name: "index_examinations_on_clinic_id"
    t.index ["doctor_id"], name: "index_examinations_on_doctor_id"
    t.index ["patient_id"], name: "index_examinations_on_patient_id"
  end

  create_table "manages", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "secretary_id"
    t.integer "clinic_id"
    t.index ["clinic_id"], name: "index_manages_on_clinic_id"
    t.index ["secretary_id"], name: "index_manages_on_secretary_id"
  end

  create_table "owners", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "email"
  end

  create_table "patients", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prescripted_examinations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prescriptions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "examination_id"
    t.string "type"
    t.string "comment"
    t.string "drugName"
    t.index ["examination_id"], name: "index_prescriptions_on_examination_id"
  end

  create_table "secretaries", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.string "email"
    t.string "password_digest"
    t.string "birthdayDate"
    t.string "birthdayPlace"
    t.string "phoneNumber"
    t.string "cf"
    t.datetime "oauth_expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "doctorID"
    t.string "type"
    t.string "story"
    t.string "remember_digest"
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
  end

  create_table "visits", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "works", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "doctor_id"
    t.integer "clinic_id"
    t.index ["clinic_id"], name: "index_works_on_clinic_id"
    t.index ["doctor_id"], name: "index_works_on_doctor_id"
  end

end
