namespace :facebook do
	
	desc "Sync data from Facebook"
	task :sync => :environment do
		
		connection = Koala::Facebook::API.new("100619843398380|YmsDvGw8FCUxNRovvusanVDnDNA")
		items = connection.get_connections("7845355665", 'feed')
		
		items.each do |item|
			fb = FacebookMessage.find_by_fb_id(item["id"]) || FacebookMessage.new(:fb_id => item["id"])
			#fb.fb_id = item["id"]
			fb.fb_type = item["type"]
			
			fb.fb_created_at = item["created_time"]
      
			fb.from = item["from"]["name"] if item["from"].present?
			fb.from_fb_id = item["from"]["id"] if item["from"].present?
			
			fb.application = item["application"]["name"] if item["application"].present?
			fb.application_fb_id = item["application"]["id"] if item["application"].present?
			
			fb.to = item["to"]["name"] if item["to"].present?
			fb.to_fb_id = item["to"]["id"]  if item["to"].present?
			
			fb.message = item["message"]
			fb.link = item["link"]
			fb.picture = item["picture"]
			
			fb.save
		end unless items.empty?
		
	end
	
end
