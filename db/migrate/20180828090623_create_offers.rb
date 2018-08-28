class CreateOffers < ActiveRecord::Migration[5.2]
  def up
    create_table :offers do |t|
      t.boolean  "enabled"
      t.string   "title"
      t.string   "location"
      t.text     "description"
      t.text     "offer"
      t.boolean  "view_by_appt"
      t.string   "contact_email"
      t.string   "contact_tel"
      t.string   "website"
      t.float    "latitude"
      t.float    "longitude"
      t.string   "postcode"
      t.text     "address"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "slug"
    end
  end
  def down
    drop_table :offers
  end
end
