Spree::OrdersController.class_eval do

  def invoice
    @order=Spree::Order.find_by_number(params[:id])
  end

end
