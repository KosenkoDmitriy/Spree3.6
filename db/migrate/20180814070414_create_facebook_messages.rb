class CreateFacebookMessages < ActiveRecord::Migration[5.2]
  def up
    create_table :facebook_messages do |t|

      t.timestamps

      t.column :fb_id, :string
			t.column :fb_type, :string

			t.column :fb_created_at, :datetime

			t.column :from, :string
			t.column :from_fb_id, :string

			t.column :application, :string
			t.column :application_fb_id, :string

			t.column :to, :string
			t.column :to_fb_id, :string

			t.column :message, :string
			t.column :link, :string
			t.column :picture, :string

    end
  end
  def down
    drop_table :facebook_messages
  end
end
