Spree::Admin::Orders::CustomerDetailsController.class_eval do
  def update
    if @order.update_attributes(params[:order])
      if params[:guest_checkout] == "false"
        @order.associate_user!(Spree.user_class.find_by_email(@order.email))
      end
      while @order.next; end

      @order.refresh_shipment_rates
      @order.reload
      @order.adjust_tax_charge!
      flash[:success] = Spree.t('customer_details_updated')
      redirect_to admin_order_customer_path(@order)
    else
      render :action => :edit
    end

  end
end
