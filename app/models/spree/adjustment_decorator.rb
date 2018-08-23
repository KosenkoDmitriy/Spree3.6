Spree::Adjustment.class_eval do

  after_save :adjust_order_taxs
  after_destroy :adjust_order_taxs
  
  # testing => Spree::OrderMailer.confirm_email(Spree::Order.find_by_number("R872348883")).body
  scope :discount, lambda{ where("(label NOT LIKE ?) AND (originator_type IS NULL)", "%shipping%") }
  scope :shipping_costs, lambda{ where("(label LIKE ?) AND (originator_type IS NULL OR originator_type != 'Spree::TaxRate')", "%shipping%") } # 
  scope :not_shipping_costs, lambda{ where("(label NOT LIKE ?) OR (originator_type = 'Spree::TaxRate')", "%shipping%") }
  
  private
  
  def adjust_order_taxs
    if self.source.nil? && self.originator.nil? && adjustable.is_a?(Spree::Order)
      adjustable.create_tax_charge!
    end
  end

end
