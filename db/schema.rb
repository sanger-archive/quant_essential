# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160427113532) do

  create_table "assay_sets", force: :cascade do |t|
    t.uuid     "uuid",       limit: 16, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "assays", force: :cascade do |t|
    t.integer  "assay_set_id", limit: 4, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "assays", ["assay_set_id"], name: "fk_rails_6985200135", using: :btree

  create_table "barcodes", force: :cascade do |t|
    t.integer  "barcodable_id",   limit: 4,   null: false
    t.string   "barcodable_type", limit: 255, null: false
    t.string   "barcode",         limit: 255, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "barcodes", ["barcode"], name: "index_barcodes_on_barcode", using: :btree

  create_table "inputs", force: :cascade do |t|
    t.uuid     "uuid",          limit: 16,  null: false
    t.string   "external_type", limit: 255, null: false
    t.integer  "source_id",     limit: 4,   null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "inputs", ["source_id"], name: "fk_rails_2cf6808511", using: :btree

  create_table "quant_types", force: :cascade do |t|
    t.string   "name",             limit: 255, null: false
    t.integer  "standard_type_id", limit: 4,   null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "quant_types", ["standard_type_id"], name: "fk_rails_766d373994", using: :btree

  create_table "quants", force: :cascade do |t|
    t.integer  "quant_type_id", limit: 4, null: false
    t.integer  "assay_id",      limit: 4, null: false
    t.integer  "input_id",      limit: 4, null: false
    t.integer  "standard_id",   limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "quants", ["assay_id"], name: "fk_rails_bc5c1a302c", using: :btree
  add_index "quants", ["input_id"], name: "fk_rails_5d15d3a6c3", using: :btree
  add_index "quants", ["quant_type_id"], name: "fk_rails_50b99a5d2f", using: :btree
  add_index "quants", ["standard_id"], name: "fk_rails_fcee5c97e0", using: :btree

  create_table "sources", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.string   "key",        limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "standard_sets", force: :cascade do |t|
    t.uuid     "uuid",       limit: 16, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "standard_types", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "standards", force: :cascade do |t|
    t.integer  "standard_set_id",  limit: 4, null: false
    t.integer  "standard_type_id", limit: 4, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "standards", ["standard_set_id"], name: "fk_rails_bbe8ff187d", using: :btree
  add_index "standards", ["standard_type_id"], name: "fk_rails_143f4c4c17", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "login",                    limit: 255, null: false
    t.uuid     "uuid",                     limit: 16
    t.string   "encrypted_swipecard_code", limit: 255, null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_foreign_key "assays", "assay_sets"
  add_foreign_key "inputs", "sources"
  add_foreign_key "quant_types", "standard_types"
  add_foreign_key "quants", "assays"
  add_foreign_key "quants", "inputs"
  add_foreign_key "quants", "quant_types"
  add_foreign_key "quants", "standards"
  add_foreign_key "standards", "standard_sets"
  add_foreign_key "standards", "standard_types"
end
