Spree::Image.class_eval do
  # has_attached_file(
  #   :attachment,
  #   :processors => [:thumbnail, :watermark],
    # :styles => {
    #   :mini => {
    #     :geometry => '48x48#',
    #     :watermark_path => "#{Rails.root.to_s}/private/watermarks/mini.png",
    #     :watermark_position => "SouthEast",
    #     :format => :png,
    #   },
    #   :small => {
    #     :geometry => '100x100#',
    #     :watermark_path => "#{Rails.root.to_s}/private/watermarks/small.png",
    #     :watermark_position => "SouthEast",
    #     :format => :png,
    #   },
		# 	:catalogue => {
		# 		:geometry => '220x180#',
    #     :watermark_path => "#{Rails.root.to_s}/private/watermarks/catalogue.png",
    #     :watermark_position => "SouthEast",
    #     :format => :png,
		# 	},
    #   :product => {
    #     :geometry => '290x',
    #     :watermark_path => "#{Rails.root.to_s}/private/watermarks/product.png",
    #     :watermark_position => "SouthEast",
    #     :format => :png,
    #   },
    #   :large => {
    #     :geometry => '480x600>',
    #     :watermark_path => "#{Rails.root.to_s}/private/watermarks/large.png",
    #     :watermark_position => "SouthEast",
    #     :format => :png,
    #   },
    # },
  #   :default_style => :product,
  #   :url => "/spree/products/:id/:style/:basename.:extension",
  #   :path => ":rails_root/public/spree/products/:id/:style/:basename.:extension"
  #   )
  # validates_attachment_content_type :attachment, content_type: /\Aimage\/.*\z/
end
