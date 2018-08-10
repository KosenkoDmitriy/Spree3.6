Spree::CheckoutController.class_eval do

	before_action :check_for_terms_agreement, :only => [:update]

	def check_for_terms_agreement
		@order.agreed_to_terms = params[:order][:agreed_to_terms] if params[:order] && params[:order].has_key?(:agreed_to_terms)

		if (@order.agreed_to_terms != true)
			redirect_to(checkout_state_path("address"), :flash => {:error => "You must agree to the terms and conditions"}) and return false
		end

	end

  private

  def load_order
    @order = current_order
    @order.origination = :frontend
    redirect_to spree.cart_path and return unless @order

    if params[:state]
      redirect_to checkout_state_path(@order.state) if @order.can_go_to_state?(params[:state]) && !skip_state_validation?
      @order.state = params[:state]
    end
  end

end
