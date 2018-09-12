require_dependency 'spree/calculator'

module Spree
  class Calculator::SoulpadDefaultTax < Calculator
    def self.description
      Spree.t(:soulpad_default_tax)
    end

    def compute(computable)
      case computable
        when Spree::Order
          compute_order(computable)
        when Spree::LineItem
          compute_line_item(computable)
      end
    end


    private

      def rate
        self.calculable
      end

      def compute_order(order)
        matched_line_items = order.line_items.select do |line_item|
          line_item.tax_category == rate.tax_category
        end

        if rate.tax_category.name == "Standard VAT" && !rate.amount.zero?
          adjustment_totals_less_tax = Array.new
          # Get manual Adjustments
          matched_adjustment_amounts = order.adjustments.select do |adjustment|
            adjustment.source.nil? && adjustment.originator.nil?
          end.map do |adjustment|
            adjustment_tax_part = (adjustment.amount - (adjustment.amount / (1 + rate.amount)))
            adjustment.amount - adjustment_tax_part
          end
        end

        logger.info "======================================="
        logger.info "Doing Tax"
        logger.info "======================================="

        total_less_taxes = matched_line_items.sum(&:total)
        total_less_taxes += matched_adjustment_amounts.sum if matched_adjustment_amounts
        total_less_taxes * rate.amount
      end

      def compute_line_item(line_item)
        if line_item.tax_category == rate.tax_category
          if rate.included_in_price
            deduced_total_by_rate(line_item.total, rate)
          else
            round_to_two_places(line_item.total * rate.amount)
          end
        else
          0
        end
      end

      def round_to_two_places(amount)
        BigDecimal.new(amount.to_s).round(2, BigDecimal::ROUND_HALF_UP)
      end

      def deduced_total_by_rate(total, rate)
        round_to_two_places(total - ( total / (1 + rate.amount) ) )
      end

  end
end
