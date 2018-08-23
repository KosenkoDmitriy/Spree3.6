Spree::Zone.class_eval do
    
  def kind
    @zone_kind ||= if members.any? && !members.any? { |member| member.try(:zoneable_type).nil? }
      members.last.zoneable_type.demodulize.underscore
    end
  end
  
  def self.match_for_tax address
    return unless matches = self.includes(:zone_members).
      order('zone_members_count', 'created_at').
      select { |zone| zone.include? address }

    ['state', 'country'].each do |zone_kind|
      match = matches.detect { |zone| zone_kind == zone.kind }
      if match && Spree::TaxRate.where(zone_id: match.id).length > 0 
        return match
      end
    end
    matches.select{|match| Spree::TaxRate.where(zone_id: match.id).length > 0 }.first
  end

end