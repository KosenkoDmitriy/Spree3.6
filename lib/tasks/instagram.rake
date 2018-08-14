require 'instagram'

namespace :insta do

	desc "Sync photos from Instagram"
	task :sync => :environment do

    client = Instagram.client(access_token: Instagram.access_token)
    recents = client.user_recent_media :count => 9
    recents.each do |media|
      insta_local = InstaPhoto.find_by_insta_id(media.id) || InstaPhoto.new(:insta_id => media.id.to_s)
      insta_local.uploaded_at = Time.at(media.created_time.to_i)
      insta_local.title = media.caption.text
      insta_local.link = media.link
      insta_local.thumb = media.images.thumbnail.url
      insta_local.save
    end

	end

end
