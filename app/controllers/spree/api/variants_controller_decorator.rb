# Spree::Api::V1:VariantsController.class_eval do
#   def index
#     @variants = scope.includes(:option_values, :stock_items, :product, :images, :prices).where("spree_stock_items.deleted_at IS NULL").ransack(params[:q]).result.
#       page(params[:page]).per(params[:per_page])
#     respond_with(@variants)
#   end
# end
