class CreatePosts < ActiveRecord::Migration[5.2]
  def up
    create_table :posts do |t|
      t.string   "title"
      t.text     "body"
      t.string   "post_type"
      t.date     "published_on"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.text     "body_extended"
      t.string   "permalink"
    end
  end
  def down
    drop_table :posts
  end
end
