class CreateFeatures < ActiveRecord::Migration[5.2]
  def up
    create_table :features do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.boolean  :enabled, default: false
      t.string   :title
      t.text     :description
      t.string   :link
      t.integer  :product_id
      t.string   :attachment_content_type
      t.string   :attachment_file_name
      t.integer  :attachment_size
      t.datetime :attachment_updated_at
      t.integer  :attachment_width
      t.integer  :attachment_height
      t.string   :shop_enabled
    end
  end
  def down
    drop_table :features
  end
end
