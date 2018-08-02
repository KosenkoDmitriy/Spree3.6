Photo.class_eval do

  has_attached_file :file, 
    :processors => [:thumbnail, :watermark],
    :styles => { 
      :mini => {
        :geometry => '60x60#',
        :watermark_path => "#{Rails.root.to_s}/private/watermarks/mini.png",
        :watermark_position => "SouthEast",
        :format => :png
        },
      :small => {
          :geometry =>'140x140#',
          :watermark_path => "#{Rails.root.to_s}/private/watermarks/small.png",
          :watermark_position => "SouthEast",
          :format => :png
        },
      :normal => {
        :geometry =>'300x300>',
        
        :watermark_path => "#{Rails.root.to_s}/private/watermarks/product.png",
        :watermark_position => "SouthEast",
        :format => :png
      },
      :large => {
        :geometry =>'620x620>',
        :watermark_path => "#{Rails.root.to_s}/private/watermarks/large.png",
        :watermark_position => "SouthEast",
        :format => :png
      },
      :category => {
        :geometry =>'300x300>',
        :format => :png
      },
      :large_no_watermark => {
        :geometry =>'620x620>',
        :format => :png
      },
    }, 
    :default_style => :normal,
    :url => "/spree/photos/:id/:style/:basename.:extension",
    :path => ":rails_root/public/spree/photos/:id/:style/:basename.:extension"
  
  #before_file_post_process :do_not_watermark_categoty_photos



  #  def do_not_watermark_categoty_photos
  #    Rails.logger.debug "running before_file_post_process and returning #{gallery.category_gallery?}"
  #    # To ensure the Category thumb nails dont get the watermark
  #    #return false if gallery.category_gallery?
  #  end
    
end