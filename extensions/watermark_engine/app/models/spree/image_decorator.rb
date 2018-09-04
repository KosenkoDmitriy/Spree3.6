# Spree::Image.class_eval do
# # Spree::Asset.class_eval do
# # has_one_attached :attachment
# # has_attached_file :attachment
#   # has_attached_file :attachment, styles: { mini: '100x100#'}
# #   # validates_attachment :attachment, content_type: { content_type: /\Aimage\/.*\z/ }
# #   #                   styles: { thumbnail: "48x48>", main: "940x325#", shop_main: "700x325#", shop_small: "340X325#" },
# #   #                   default_style: :main,
# #   #                   default_url: "/spree/features/:style/missing.png",
# #   #                   url: "/spree/features/:id/:style/:basename.:extension",
# #   #                   path: ":rails_root/public/spree/features/:id/:style/:basename.:extension"
# #   has_attached_file(
# #     :attachment,
# #
# #     )
# #   # validates_attachment_content_type :attachment, content_type: /\Aimage\/.*\z/
#   # do_not_validate_attachment_file_type :attachment
# #
# end
#
Spree::Image.class_eval do
  # has_attached_file :attachment, styles: { mini: '100x100#'}
  # validates_attachment :attachment, content_type: { content_type: /\Aimage\/.*\z/ }
  #                   styles: { thumbnail: "48x48>", main: "940x325#", shop_main: "700x325#", shop_small: "340X325#" },
  #                   default_style: :main,
  #                   default_url: "/spree/features/:style/missing.png",
  #                   url: "/spree/features/:id/:style/:basename.:extension",
  #                   path: ":rails_root/public/spree/features/:id/:style/:basename.:extension"
  has_attached_file(
    :attachment,
    :processors => [:thumbnail, :watermark],
    :styles => {
      :mini => {
        :geometry => '48x48#',
        :watermark_path => "#{Rails.root.to_s}/private/watermarks/mini.png",
        :watermark_position => "SouthEast",
        :format => :png,
      },
      :small => {
        :geometry => '100x100#',
        :watermark_path => "#{Rails.root.to_s}/private/watermarks/small.png",
        :watermark_position => "SouthEast",
        :format => :png,
      },
			:catalogue => {
				:geometry => '220x180#',
        :watermark_path => "#{Rails.root.to_s}/private/watermarks/catalogue.png",
        :watermark_position => "SouthEast",
        :format => :png,
			},
      :product => {
        :geometry => '290x',
        :watermark_path => "#{Rails.root.to_s}/private/watermarks/product.png",
        :watermark_position => "SouthEast",
        :format => :png,
      },
      :large => {
        :geometry => '480x600>',
        :watermark_path => "#{Rails.root.to_s}/private/watermarks/large.png",
        :watermark_position => "SouthEast",
        :format => :png,
      },
    },
    :default_style => :product,
    :url => "/spree/products/:id/:style/:basename.:extension",
    :path => ":rails_root/public/spree/products/:id/:style/:basename.:extension"
    )
  # validates_attachment_content_type :attachment, content_type: /\Aimage\/.*\z/
end
