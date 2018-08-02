class DropImageFieldsFromOffer < ActiveRecord::Migration
  def up
    remove_column :offers, :image_file_name
    remove_column :offers, :image_content_type
    remove_column :offers, :image_file_size
    remove_column :offers, :image_updated_at
  end

  def down
  end
end
