class AddExtraDescriptionFieldsToSpreeProducts < ActiveRecord::Migration[5.2]
  def self.up
		add_column :spree_products, :description_details, :text
		add_column :spree_products, :description_technique, :text
  end

  def self.down
		remove_column :spree_products, :description_technique
		remove_column :spree_products, :description_details
  end

end
