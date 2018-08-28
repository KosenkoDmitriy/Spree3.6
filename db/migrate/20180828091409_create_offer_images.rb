class CreateOfferImages < ActiveRecord::Migration[5.2]
  def up
    create_table :offer_images do |t|
      t.string   "caption"
      t.integer  "offer_id"
      t.datetime "created_at",        null: false
      t.datetime "updated_at",        null: false
      t.string   "image_file_name"
      t.string   "image_content_type"
      t.integer  "image_file_size"
      t.datetime "image_updated_at"
    end
  end
  def down
    drop_table :offer_images
  end
end
