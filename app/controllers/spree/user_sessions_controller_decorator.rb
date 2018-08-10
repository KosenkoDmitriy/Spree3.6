Spree::UserSessionsController.class_eval do
	include BasketSummary
	# before_filter :find_basket#
	layout "application"
end