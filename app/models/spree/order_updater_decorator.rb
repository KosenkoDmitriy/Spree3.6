Spree::OrderUpdater.class_eval do
  
  # Updates the following Order total values:
  #
  # +payment_total+      The total value of all finalized Payments (NOTE: non-finalized Payments are excluded)
  # +item_total+         The total value of all LineItems
  # +adjustment_total+   The total value of all adjustments (promotions, credits, etc.)
  # +total+              The so-called "order total."  This is equivalent to +item_total+ plus +adjustment_total+.
  def update_totals
    order.payment_total = payments.completed.map(&:amount).sum
    order.item_total = line_items.map(&:amount).sum
    order.adjustment_total = calculate_adjustment_total
    order.total = order.item_total + order.adjustment_total
  end

  #adjustments.eligible.map(&:amount).sum  
  def calculate_adjustment_total

    total = 0.0
    
    adjustments.eligible.each do |adjustment|
      total += if adjustment.source.nil? && adjustment.originator.nil?
        # get standard rate tax for order
        standard_rate_tax_for_order = Spree::TaxRate.match(order).detect{ |tax_rate| tax_rate.tax_category.name == "Standard VAT" }
        adjustment_tax_part = (adjustment.amount - (adjustment.amount / (1 + standard_rate_tax_for_order.amount)))
        adjustment.amount - adjustment_tax_part
      else
        adjustment.amount
      end
    end
    
    total.round(3)
  end
  
  # Override from spree master @ v2.2.2
  def update_payment_state
    last_state = order.payment_state
    if payments.present? && payments.last.state == 'failed'
      order.payment_state = 'failed'
    else
      outstanding_balance = order.outstanding_balance.round(2)
      order.payment_state = 'balance_due' if outstanding_balance > 0
      order.payment_state = 'credit_owed' if outstanding_balance < 0
      order.payment_state = 'paid' if outstanding_balance == 0
    end
    order.state_changed('payment') if last_state != order.payment_state
  end
  
end
