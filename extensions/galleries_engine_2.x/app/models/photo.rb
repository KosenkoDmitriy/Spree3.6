class Photo < ActiveRecord::Base
	
	belongs_to :gallery
	
	validate :no_attachement_errors
	has_attached_file :file, 
                    :styles => { :mini => '60x60#', :small => '140x140#', :normal => '300x300>', :large => '620x620>' }, 
                    :default_style => :normal,
                    :url => "/spree/photos/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/spree/photos/:id/:style/:basename.:extension"
	
	attr_accessible :caption, :file
	
	protected
	
	# if there are errors from the plugin, then add a more meaningful message
	def no_attachement_errors
	  unless file.errors.empty?
	    # uncomment this to get rid of the less-than-useful interrim messages
	    # errors.clear 
	    errors.add :file, "Paperclip returned errors for file '#{file_file_name}' - check ImageMagick installation or image source file."
	    false
	  end
	end
	
end