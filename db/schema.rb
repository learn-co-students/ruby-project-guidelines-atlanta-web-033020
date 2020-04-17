# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_14_191317) do

  create_table "dogs", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.string "breed"
    t.boolean "adoption_ready"
    t.integer "shelter_id"
    t.integer "owner_id"
  end

  create_table "dogs_traits", force: :cascade do |t|
    t.integer "dog_id"
    t.integer "trait_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.integer "shelter_id"
    t.integer "user_id"
  end

  create_table "shelters", force: :cascade do |t|
    t.string "name"
    t.string "address"
  end

  create_table "traits", force: :cascade do |t|
    t.string "trait_name"
  end

  create_table "traits_users", force: :cascade do |t|
    t.integer "trait_id"
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "address"
    t.string "dog_breed_preference"
    t.integer "dog_age_preference"
  end

end
