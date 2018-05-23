create_table "market_angars", force: :cascade do |t|
  t.string   "name"
  t.string   "address"
  t.integer  "stages"
  t.datetime "created_at", null: false
  t.datetime "updated_at", null: false
  t.float    "lat"
  t.float    "lng"
  t.index ["name"], name: "index_market_angars_on_name", unique: true
end
