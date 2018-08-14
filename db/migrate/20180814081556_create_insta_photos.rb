class CreateInstaPhotos < ActiveRecord::Migration[5.2]
  def self.up
    create_table :insta_photos do |t|
      t.string :insta_id
      t.datetime :uploaded_at
      t.string :title
      t.string :link
      t.string :thumb
      t.timestamps
    end
  end

  def self.down
    drop_table :insta_photos
  end
end
