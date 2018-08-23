Spree::Taxon.class_eval do
	def image
		# Photo.where(:caption => name.parameterize).first
		self.icon
	end
end
