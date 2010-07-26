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

ActiveRecord::Schema.define(:version => 20100726183746) do

  create_table "war_events", :id => false, :force => true do |t|
    t.string "report_key"
    t.string "date"
    t.string "type"
    t.string "category"
    t.string "tracking_number"
    t.text   "title"
    t.text   "summary"
    t.string "region"
    t.string "attack_on"
    t.string "complex_attack"
    t.string "reporting_unit"
    t.string "unit_name"
    t.string "type_of_unit"
    t.string "friendly_wia"
    t.string "friendly_kia"
    t.string "host_nation_wia"
    t.string "host_nation_kia"
    t.string "civilian_wia"
    t.string "civilian_kia"
    t.string "enemy_wia"
    t.string "enemy_kia"
    t.string "enemy_detained"
    t.string "mgrs"
    t.string "latitude"
    t.string "longitude"
    t.string "originator_group"
    t.string "updated_by_group"
    t.string "ccir"
    t.string "sigact"
    t.string "affiliation"
    t.string "d_color"
    t.string "classification"
  end

end
