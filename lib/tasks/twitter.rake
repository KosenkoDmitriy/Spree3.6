# namespace :twitter do
#
#   desc "Sync with Twitter"
#   task :sync => :environment do
#
#     client = Twitter::REST::Client.new do |config|
#       config.consumer_key = "9FrtJ6Se5QVbcurg2gnB5g"
#       config.consumer_secret = "thpGs40ALvIxVWOUowAHWaPsmNu8RWewLMAeN5Doskc"
#       config.access_token = "3196831-Jv8TTcQvxkoG2swKvU59xcIUxOqp1bZq37dnRnT7g"
#       config.access_token_secret = "2pFRPRZcYu196SancREzzoESJBhzoSAkrtfTMmE7mE"
#       config.connection_options[:request][:timeout] = 300
#       config.connection_options[:request][:open_timeout] = 300
#     end
#
#     client.user_timeline("SoulPad").each do |tweet|
#
#       twitter_message = TwitterMessage.find_by_twitter_id(tweet.id.to_s) || TwitterMessage.new(:twitter_id => tweet.id.to_s)
#
#       twitter_message.twitter_created_at = tweet.created_at
#       twitter_message.from = tweet.user.screen_name
#       twitter_message.from_image = tweet.user.profile_image_url
#       twitter_message.message = tweet.text
#       twitter_message.save
#     end
#   end
# end
