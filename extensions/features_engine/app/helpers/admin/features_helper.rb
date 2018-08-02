module Admin::FeaturesHelper
	
	def feature_home_enabled feature
		position = feature.shop_enabled
		!position.blank? ? "Yes - #{position.humanize}" : "No"
	end
	
end
