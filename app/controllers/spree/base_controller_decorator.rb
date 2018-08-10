Spree::BaseController.class_eval do
  before_action :authenticate_mobile

	include BasketSummary

	layout "application"

  def authenticate_mobile
  	authenticate_or_request_with_http_basic do |username, password|
  		username == "soulpad" && password == "mobile99"
  	end if ["mobile"].include?(Rails.env)
  end

end
