class ApplicationController < ActionController::Base
  include Spree::Core::ControllerHelpers::Order # for link_to_cart and basket summary

end
