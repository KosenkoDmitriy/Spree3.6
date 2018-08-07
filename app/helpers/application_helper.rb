module ApplicationHelper

  def title_without_site_name
    title_string = @title.blank? ? accurate_title : @title

    if title_string.blank?
      default_title
    else
      title_string
    end
  end

	def uk?
		I18n.locale.to_s == 'en-GB' || I18n.locale.to_s == 'en'
	end

	def usa?
		I18n.locale.to_s == 'en-US'
	end

	def aus?
		I18n.locale.to_s == 'en-AU'
	end

	def us?
		I18n.locale.to_s == 'en-US'
	end

  # Default the currency locale to the current application locale
  def number_to_currency(number, options = {})
    options[:locale] = I18n.locale
    super(number, options)
  end

	def site_selector(locale)
		case locale.to_s
		when 'en-GB'
			"<li id=\"uk\">UK</li><li id=\"us\">#{link_to 'United States', 'http://soulpad.com'}</li><li id=\"au\">#{link_to 'Australia', 'http://soulpad.com.au'}</li>"
		when 'en-AU'
			"<li id=\"au\">Australia</li><li id=\"uk\">#{link_to 'UK', 'http://soulpad.co.uk'}</li><li id=\"us\">#{link_to 'United States', 'http://soulpad.com'}</li>"
		when 'en-US'
			"<li id=\"us\">United States</li><li id=\"uk\">#{link_to 'UK', 'http://soulpad.co.uk'}</li><li id=\"au\">#{link_to 'Australia', 'http://soulpad.com.au'}</li>"
    else #default
      "<li id=\"us\">United States</li><li id=\"uk\">#{link_to 'UK', 'http://soulpad.co.uk'}</li><li id=\"au\">#{link_to 'Australia', 'http://soulpad.com.au'}</li>"
    end
	end
end
