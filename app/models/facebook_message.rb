class FacebookMessage < ApplicationRecord
  # attr_accessible :created_at, :updated_at, :fb_id, :fb_type, :fb_created_at, :from,
  # :from_fb_id, :application, :application_fb_id, :to, :to_fb_id, :message, :link, :picture


	def self.get_updates
		connection = Koala::Facebook::GraphAPI.new
		connection.get_connections(Spree::Config.get(:soulpap_facebook_id), 'feed')
	end

	def self.build_from_graph_api_hash hash
		message = FacebookMessage.new
	end
end
