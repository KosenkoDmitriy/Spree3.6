module Spree
  module BaseHelper

    # Delivery & Shipping change specific to the UK:
    #   UK customers should only be able to select the United Kingdom for shipping.
    #   USA customers choose from only USA & Canada
    #   SoulPad ships worldwide so admin address form should show all countries.
    #   All countries must remain in the spree_countries table due to previous orders needing country data.

    def all_available_countries
      #used in backend to allow billing & delivery address to be worldwide
      checkout_zone = Zone.find_by_name(Spree::Config[:checkout_zone])
      if checkout_zone && checkout_zone.kind == 'country'
        countries = checkout_zone.country_list
      else
        countries = Country.all
      end
      countries.collect do |country|
        country.name = Spree.t(country.iso, scope: 'country_names', default: country.name)
        country
      end.sort_by { |c| c.name.parameterize }
    end

    def aus_available_countries
      Rails.logger.info("Overriding Australian country selection to only AUS & NZ")
      Country.where(:iso3 => ["AUS", "NZL"])
    end

    def uk_available_countries
      #used in frontend to prevent selection of any country except UK
      Rails.logger.info("Overriding UK country selection because locale is #{I18n.locale.to_s}")
      Country.where(:iso3 => "GBR")
    end

    def usa_available_countries
      Rails.logger.info("Overriding USA country selection to only USA, Canada & Mexico because locale is #{I18n.locale.to_s}")
      Country.where(:iso3 => ["USA", "CAN", "MEX"])
    end

    def available_countries
      if uk?
        uk_available_countries
      elsif usa?
        usa_available_countries
      elsif aus?
        aus_available_countries
      else
        all_available_countries
      end
    end

  end
end