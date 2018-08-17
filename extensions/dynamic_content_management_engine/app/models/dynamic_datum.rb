class DynamicDatum < ActiveRecord::Base

	#extend ActionView::Helpers::RawOutputHelper
	extend ActionView::Helpers::TagHelper

	def self.render_by_tag tag, opts = Hash.new
		content_tag :div, DynamicDatum.where(:tag => tag).first.data.html_safe
	rescue
		"missing text for #{tag}"
	end

end
