class CreateOfferImages < ActiveRecord::Migration
  def change
    create_table :offer_images do |t|
      t.string :caption
      t.integer :offer_id

      t.timestamps
    end
  end
end
