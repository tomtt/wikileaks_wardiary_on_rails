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

ActiveRecord::Schema.define(:version => 20100729033959) do

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "taggable_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
    t.string "cached_slug"
  end

  create_table "term_definitions", :force => true do |t|
    t.string   "term",       :null => false
    t.string   "pattern"
    t.text     "definition", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "term_definitions", ["term"], :name => "index_term_definitions_on_term", :unique => true

  create_table "war_events", :force => true do |t|
    t.string   "report_key",       :null => false
    t.datetime "date"
    t.string   "type_of_event"
    t.string   "category"
    t.string   "tracking_number"
    t.text     "title"
    t.text     "summary"
    t.string   "region"
    t.string   "attack_on"
    t.string   "complex_attack"
    t.string   "reporting_unit"
    t.string   "unit_name"
    t.string   "type_of_unit"
    t.integer  "friendly_wia"
    t.integer  "friendly_kia"
    t.integer  "host_nation_wia"
    t.integer  "host_nation_kia"
    t.integer  "civilian_wia"
    t.integer  "civilian_kia"
    t.integer  "enemy_wia"
    t.integer  "enemy_kia"
    t.integer  "enemy_detained"
    t.string   "mgrs"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "originator_group"
    t.string   "updated_by_group"
    t.string   "ccir"
    t.string   "sigact"
    t.string   "affiliation"
    t.string   "d_color"
    t.string   "classification"
  end

  add_index "war_events", ["report_key"], :name => "index_war_events_on_report_key", :unique => true

end
