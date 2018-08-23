#__END__
Spree::TaxRate.class_eval do
  
  scope :tax_rate, ->(tax_zone, tax_category) { where('zone_id = ? and tax_category_id = ?', tax_zone, tax_category) }

  # Overridden form spree_core to only add default rates as a last resort
  def self.match order, fallback_to_default = true
    rates = Array.new
    
    order_tax_zone = order.tax_zone
    
    return rates unless order_tax_zone
    
    # Removed due to very expensive lookup in rate.zone.contains?(order_tax_zone)
    #self.all.each do |rate|
    #  rates << rate if (rate.zone == order_tax_zone) || rate.zone.contains?(order_tax_zone)
    #end
    zone_ids = case order_tax_zone
    when Spree::Zone
      [order_tax_zone.id]
    else
      Spree::ZoneMember.where(zoneable_type: order_tax_zone.class.to_s, zoneable_id: order_tax_zone.id).map(&:zone).map(&:id)
    end
      

    rates += Spree::TaxRate.where(zone_id: zone_ids).all
    
    
    # Add default tax zone rates if rates are empty
    rates.push(*Spree::Zone.default_tax.tax_rates.all) if fallback_to_default && rates.empty?
    
    #rates.push self.where(:name => "UK Standard VAT").first if 
    # Push on Standard VAT for the order.tax_zoe
    #rates.push order.tax_zone.tax_rates.detect{ |rate| rate.name =~ /uk standard vat/i }
    
    return rates.uniq.compact
  end
  
  def self.adjust(order)
    order.adjustments.tax.destroy_all
    order.line_item_adjustments.where(originator_type: 'Spree::TaxRate').destroy_all
    
    order.reload

    Rails.logger.info "order ajudtments: #{order.adjustments.all.inspect}"

    self.match(order).each do |rate|
      rate.adjust(order)
    end
  end
  
  def self.shipping_inc_tax(order, shipping_costs)
    tax_zone = order.tax_zone
    tax_category = order.line_items.all.first.tax_category
    shipping_tax = tax_rate_for_zone_and_category(tax_zone, tax_category)
    ((shipping_costs.sum(&:amount).to_f) * (1 + shipping_tax))
  end

  private

  def self.tax_rate_for_zone_and_category(tax_zone, tax_category)
    if rate = tax_rate(tax_zone, tax_category).where("name like ?", "%Shipping%").first
      rate.amount
    else
      0
    end
  end
  
end
