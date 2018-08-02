class Gallery < ActiveRecord::Base
	
	has_many :photos, :dependent => :destroy
	
	attr_accessible :title, :enabled, :description, :category
	
	validates_presence_of :title
	
	scope :enabled, :conditions => {:enabled => true}

	def category_gallery?
		self.title == 'Categories'
	end

  def self.category_list
    Gallery.uniq.pluck(:category).map{|c| c}
	end

end