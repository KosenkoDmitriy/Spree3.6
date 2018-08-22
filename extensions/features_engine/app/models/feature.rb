class Feature < ActiveRecord::Base

  belongs_to :spree_product, :foreign_key => "product_id", :class_name => "Spree::Product"

  has_attached_file :attachment,
                    styles: { thumbnail: "48x48>", main: "940x325#", shop_main: "700x325#", shop_small: "340X325#" },
                    default_style: :main,
                    default_url: "/spree/features/:style/missing.png",
                    url: "/spree/features/:id/:style/:basename.:extension",
                    path: ":rails_root/public/spree/features/:id/:style/:basename.:extension"
  validate :no_attachment_errors
  # do_not_validate_attachment_file_type :attachment
  # validates_attachment_content_type :attachment, content_type: /\Aimage\/.*\z/
  validates_attachment :attachment, content_type: { content_type: /\Aimage\/.*\z/ }


  scope :enabled,   -> { where(enabled: true) }
  scope :shop_main, -> { where(shop_enabled: 'main') }
  scope :shop_small_left, -> { where(shop_enabled: 'small_left') }
  scope :shop_small_right, -> { where(shop_enabled: 'small_right') }


  def links_to_product?
    self.spree_product.present?
  end

  def product_name
    ""
    if links_to_product?
      self.spree_product.name
    end
  end

  def no_attachment_errors
    unless attachment.errors.empty?
      errors.add :attachment, "Paperclip returned errors for file '#{attachment_file_name}' - check ImageMagick installation or image source file."
      false
    end
  end

  def display_title
    text = self.title
    text = self.spree_product.name if self.links_to_product?
    text = "Untitled" if text.blank?
    text
  end

  def home_enabled
    position = self.shop_enabled
    !position.blank? ? "#{position.humanize}" : "No"
  end

end
