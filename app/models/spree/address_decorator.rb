Spree::Address.class_eval do
  # Used as a special SoulPad check to see if extra cost for shipping is required
  def is_international?
    self.country_id != Spree::Config[:default_country_id]
  end

  def full_address
    ["#{firstname} #{lastname}",
    address1,
    address2,
    city,
    (state || state_name),
    zipcode,
    country.name].delete_if{|a|a.blank?}
  end
end
