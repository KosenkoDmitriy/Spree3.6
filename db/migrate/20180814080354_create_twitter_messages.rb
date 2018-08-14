class CreateTwitterMessages < ActiveRecord::Migration[5.2]
  def up
    create_table :twitter_messages do |t|
      t.timestamps

			t.column :twitter_id, :string
			t.column :twitter_created_at, :datetime

			t.column :from, :string
			t.column :from_image, :string
			t.column :message, :string
			t.column :link, :string
    end
  end
  def down
    drop_table :twitter_messages
  end
end
