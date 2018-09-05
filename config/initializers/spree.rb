# Configure Spree Preferences
#
# Note: Initializing preferences available within the Admin will overwrite any changes that were made through the user interface when you restart.
#       If you would like users to be able to update a setting with the Admin it should NOT be set here.
#
# Note: If a preference is set here it will be stored within the cache & database upon initialization.
#       Just removing an entry from this initializer will not make the preference value go away.
#       Instead you must either set a new value or remove entry, clear cache, and remove database entry.
#
# In order to initialize a setting do:
# config.setting_name = 'new value'
Spree.config do |config|
  # Example:
  # Uncomment to stop tracking inventory levels in the application
  # config.track_inventory_levels = false
end

Spree.user_class = "Spree::User"

# Spree::Image.attachment_definitions[:attachment][:processors] = [:thumbnail, :watermark]
# # Spree::Image.attachment_definitions[:attachment][:processors] = :watermark
# Spree::Image.attachment_definitions[:attachment][:default_style] = :product
# Spree::Image.attachment_definitions[:attachment][:url] = "/spree/products/:id/:style/:basename.:extension", #':path'
# Spree::Image.attachment_definitions[:attachment][:path] = ":rails_root/public/spree/products/:id/:style/:basename.:extension"
# Spree::Image.attachment_definitions[:attachment][:styles] = {
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
#   :catalogue => {
#     :geometry => '220x180#',
#     :watermark_path => "#{Rails.root.to_s}/private/watermarks/catalogue.png",
#     :watermark_position => "SouthEast",
#     :format => :png,
#   },
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
# }
