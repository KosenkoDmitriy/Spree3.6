Spree::User.class_eval do

  # Ensure emails cannot contain HTML.
  validates :email, format: { with: /\A[^<>]+\z/ }

  def recent_ship_address
    Spree::Order.where(:email => self.email).last.ship_address
  rescue
    nil
  end

  def recent_bill_address
    Spree::Order.where(:email => self.email).last.bill_address
  rescue
    nil
  end

end
