Spree::Admin::ReportsController.class_eval do

  def initialize
    super
    Spree::Admin::ReportsController.add_available_report!(:sales_total, 'sales totals for all orders')
    Spree::Admin::ReportsController.add_available_report!(:sales_total_inc_vat, 'sales totals for all orders including VAT')
    Spree::Admin::ReportsController.add_available_report!(:sku_totals, 'Quantity Items Sold by SKU')
    Spree::Admin::ReportsController.add_available_report!(:user_emails, 'Registered Users (From Billing Address)')
  end

  def user_emails
    params[:q] = {} unless params[:q]

    if params[:q][:created_at_gt].blank?
      params[:q][:created_at_gt] = Time.zone.now.beginning_of_month
    else
      params[:q][:created_at_gt] = Time.zone.parse(params[:q][:created_at_gt]).beginning_of_day rescue Time.zone.now.beginning_of_month
    end

    if params[:q] && !params[:q][:created_at_lt].blank?
      params[:q][:created_at_lt] = Time.zone.parse(params[:q][:created_at_lt]).end_of_day rescue ""
    end

    params[:q][:s] ||= "created_at desc"

    @search = Spree::Order.complete.ransack(params[:q])
    @users = @search.result

    @user_data=[]
    @users.each do |u|
      @user_data << {:email => u.email, :firstname => u.billing_address.firstname, :lastname => u.billing_address.lastname} if u.billing_address.present?
    end
  end

  def sku_totals
    params[:q] = {} unless params[:q]
    if params[:q][:completed_at_gt].blank?
      params[:q][:completed_at_gt] = Time.zone.now.beginning_of_month
    else
      params[:q][:completed_at_gt] = Time.zone.parse(params[:q][:completed_at_gt]).beginning_of_day rescue Time.zone.now.beginning_of_month
    end
    if params[:q] && !params[:q][:completed_at_lt].blank?
      params[:q][:completed_at_lt] = Time.zone.parse(params[:q][:completed_at_lt]).end_of_day rescue ""
    end

    params[:q][:s] ||= "completed_at desc"

    @search = Spree::Order.complete.ransack(params[:q])
    @orders = @search.result.joins(line_items: :variant).uniq

    @skus=[]
    totals = []
    @orders.each do |order|
      order.line_items.each do |i|
        totals << {i.variant.sku => i.quantity}
      end
    end
    @skus = totals.inject{|memo, el| memo.merge( el ){|k, old_v, new_v| old_v + new_v}}.sort unless totals.empty?
  end

  def sales_total_inc_vat
    params[:q] = {} unless params[:q]

    if params[:q][:completed_at_gt].blank?
      params[:q][:completed_at_gt] = Time.zone.now.beginning_of_month
    else
      params[:q][:completed_at_gt] = Time.zone.parse(params[:q][:completed_at_gt]).beginning_of_day rescue Time.zone.now.beginning_of_month
    end

    if params[:q] && !params[:q][:completed_at_lt].blank?
      params[:q][:completed_at_lt] = Time.zone.parse(params[:q][:completed_at_lt]).end_of_day rescue ""
    end

    params[:q][:s] ||= "completed_at desc"

    @search = Spree::Order.complete.ransack(params[:q])
    @orders = @search.result

    @totals = {}
    @orders.each do |order|
      @totals[order.currency] = { :item_total => ::Money.new(0, order.currency), :adjustment_total => ::Money.new(0, order.currency), :sales_total => ::Money.new(0, order.currency), :tax_total => ::Money.new(0, order.currency) } unless @totals[order.currency]
      @totals[order.currency][:item_total] += order.display_item_total.money
      @totals[order.currency][:adjustment_total] += order.display_adjustment_total.money
      @totals[order.currency][:sales_total] += order.display_total.money
      @totals[order.currency][:tax_total] += order.display_tax_total.money
    end
  end
end
