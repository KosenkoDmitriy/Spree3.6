require_dependency 'spree/calculator'

module Spree
  class Calculator::SoulpadShippingTax < Calculator
    def self.description
      "Applies Tax to the shipping amount for an order. This enables a worldwide order to have UK VAT applied to the shipping"
    end

    def compute(computable)
      #raise computable.adjustments.inspect
      case computable
        when Spree::Order
          compute_order(computable)
      end
    end
    
    private
    
    def rate
      self.calculable
    end
    
    def compute_order(order)
      running_total = 0.0
      
      #raise order.adjustments.inspect
      matched_shipping_adjustments = order.adjustments.shipping
      running_total += matched_shipping_adjustments.sum(&:amount)
      
      round_to_two_places(running_total * rate.amount)
    end
    
    def round_to_two_places(amount)
      BigDecimal.new(amount.to_s).round(2, BigDecimal::ROUND_HALF_UP)
    end

    def deduced_total_by_rate(total, rate)
      round_to_two_places(total - ( total / (1 + rate.amount) ) )
    end
    
  end
  
end