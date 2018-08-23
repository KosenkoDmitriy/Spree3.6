Spree::Order.class_eval do

  # attr_accessor :origination

	# attr_accessible :agreed_to_terms, :user_id

  # def vat_as_a_percentage_of_total vat_percentage = nil
  #   # VAT is calculated on all products in the basket, except those in the zero VAT product group
  #   #
  #   #vat_tax_category = Spree::TaxCategory.where(:name => "UK VAT")
  #   vat_rate = Spree::TaxRate.where(:name => "VAT").first
  #   vat_percentage ||= (vat_rate.amount * 100 + 100)
  #
  #   running_total = self.total
  #   self.line_items.each do |line_item|
  #     #running_total -= line_item.variant.price if line_item.variant.product.product_groups.collect{ |pg| pg.name }.include? "VAT ZERO RATE"
  #     running_total -= line_item.variant.price if line_item.variant.product.tax_category.name == "NO VAT" # product_groups.collect{ |pg| pg.name }.include? "VAT ZERO RATE"
  #   end
  #
  #   #total_exc_vat = running_total / ((vat_percentage / 100) + 1)
  #   total_exc_vat = ((running_total / vat_percentage) * 100)
  #   running_total - total_exc_vat
  # end

  after_save :adjust_tax_charge!

  def adjust_tax_charge!
    Spree::TaxRate.adjust(Spree::Order.find(self.id))
  end

  # Overriding ActiveRecord getters for totals columns so we can round to 2dp
  # Reason: we're storing item prices to 4dp, for tax/rounding issues, to avoid
  # the payments using the incorrect precision.
  # [:item_total, :total, :adjustment_total, :payment_total].each do |column_name|
#     define_method column_name do
#       base_value = read_attribute(column_name)
#       base_value.nil? ? nil : base_value.to_f.round(2)
#     end
#   end

  # def tax_zone
#     @order_tax_zone ||= lookup_tax_zone
#   end
#
#   def lookup_tax_zone
#     zone_address = Spree::Config[:tax_using_ship_address] ? ship_address : bill_address
#     (Spree::Zone.match_for_tax(zone_address) || Spree::Zone.default_tax)
#   end
  def tax_zone
    zone_address = Spree::Config[:tax_using_ship_address] ? ship_address : bill_address
    (Spree::Zone.match_for_tax(zone_address) || Spree::Zone.default_tax)
  end

  def ensure_available_shipping_rates
    if self.origination == :frontend
      if shipments.empty? || shipments.any? { |shipment| shipment.shipping_rates.frontend.blank? }
        errors.add(:base, Spree.t(:items_cannot_be_shipped)) and return false
      end
    else
      if shipments.empty? || shipments.any? { |shipment| shipment.shipping_rates.blank? }
        errors.add(:base, Spree.t(:items_cannot_be_shipped)) and return false
      end
    end
  end

  def after_cancel
    shipments.each { |shipment| shipment.cancel! unless shipment.state == 'canceled' }

    # This was copied from spree_core, so that it gets called even when orders are set to canceled
    shipments.each do |shipment|
      shipment.manifest.each { |item| self.manifest_restock(item, shipment) }
    end
    #shipments.first.manifest.each { |item| self.manifest_restock(item) }

    Spree::OrderMailer.cancel_email(self.id).deliver
    self.payment_state = 'credit_owed' unless shipped?
  end

  # This method was copied from spree_core so that it can be called from this class
  def manifest_restock(item, shipment)
    if item.states["on_hand"].to_i > 0
      shipment.stock_location.restock item.variant, item.states["on_hand"], self
    end

    if item.states["backordered"].to_i > 0
      shipment.stock_location.restock_backordered item.variant, item.states["backordered"]
    end
  end

  def line_items_total
    item_total = line_items.map {|item| item.price_inc_tax(self, price: item.amount) }
    item_total.inject(:+)
  end

  def tax_for_order
    adjustments.eligible.tax
  end

  def show_invoice?
    (self.state == Spree.t("order_state.complete")) && (self.payment_state == Spree.t("payment_states.paid"))
  end

  # Copied from: https://github.com/spree/spree/blob/2-0-stable/core/app/models/spree/order.rb#L290
  def generate_order_number
    self.number ||= loop do
      random = "#{Spree::Config[:order_number_prefix]}#{Array.new(9){rand(9)}.join}"
      break random unless self.class.exists?(number: random)
    end
  end
end
