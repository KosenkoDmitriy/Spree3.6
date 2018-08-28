class AddAttachmentImageToOfferImages < ActiveRecord::Migration
  def self.up
    change_table :offer_images do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :offer_images, :image
  end
end
