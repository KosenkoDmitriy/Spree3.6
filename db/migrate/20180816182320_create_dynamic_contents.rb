class CreateDynamicContents < ActiveRecord::Migration[5.2]
  def up
		create_table :dynamic_data, :force => true do |t|
		  t.timestamps

			t.column :tag, :string
			t.column :data, :text

		end
  end

  def down
		drop_table :dynamic_data
  end
end
