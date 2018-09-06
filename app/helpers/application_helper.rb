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

  def lang_label(locale)
    case locale.to_s
    when 'en-GB'
      'UK'
    when 'en-AU'
      'Australia'
    when 'en-US'
      'United States'
    else
      'United States'
    end
  end

  def lang_icon(locale)
    case locale.to_s
    when 'en-GB'
      image_tag("site/uk.png")
    when 'en-AU'
      image_tag("site/au.png")
    when 'en-US'
      image_tag("site/us.png")
    else # en-US locale by default
      image_tag("site/us.png")
    end
  end

  def lang_others(locale)
    case locale.to_s
    when 'en-GB'
      "<li id=\"us\"><span>#{lang_icon('en-US')} #{link_to 'United States', 'http://soulpad.com'}</span></li>
      <li id=\"au\"><span>#{lang_icon('en-AU')} #{link_to 'Australia', 'http://soulpad.com.au'}</span></li>"
    when 'en-AU'
      "<li id=\"uk\"><span>#{lang_icon('en-GB')} #{link_to 'UK', 'http://soulpad.co.uk'}<span></li>
      <li id=\"us\"><span>#{lang_icon('en-US')} #{link_to 'United States', 'http://soulpad.com'}<span></li>"
    when 'en-US'
      "<li id=\"uk\"><span>#{lang_icon('en-GB')} #{link_to 'UK', 'http://soulpad.co.uk'}<span></li>
      <li id=\"au\"><span>#{lang_icon('en-AU')} #{link_to 'Australia', 'http://soulpad.com.au'}<span></li>"
    else # en-US locale by default
      "<li id=\"uk\"><span>#{lang_icon('en-GB')} #{link_to 'UK', 'http://soulpad.co.uk'}<span></li>
      <li id=\"au\"><span>#{lang_icon('en-AU')} #{link_to 'Australia', 'http://soulpad.com.au'}<span></li>"
    end
  end

  def site_selector(locale)
    lang_label = lang_label(locale)
    "<div class='dropdown sites'>
      <button class='btn btn-default dropdown-toggle' type='button' id='dropdownLangMenu' data-toggle='dropdown' aria-haspopup='true' aria-expanded='true'>
      #{lang_icon(locale)} #{lang_label}
      <span class='glyphicon glyphicon-triangle-bottom'></span>
      </button>
      <ul class='dropdown-menu' aria-labelledby='dropdownLangMenu'>
      #{lang_others(locale)}
      </ul>
    </div>" if lang_label.present?
  end

	def site_selector_pre_spree3(locale)
		case locale.to_s
		when 'en-GB'
			"<li id=\"uk\">UK</li>
      <li id=\"us\">#{link_to 'United States', 'http://soulpad.com'}</li>
      <li id=\"au\">#{link_to 'Australia', 'http://soulpad.com.au'}</li>"
		when 'en-AU'
			"<li id=\"au\">Australia</li>
      <li id=\"uk\">#{link_to 'UK', 'http://soulpad.co.uk'}</li>
      <li id=\"us\">#{link_to 'United States', 'http://soulpad.com'}</li>"
		when 'en-US'
			"<li id=\"us\">United States</li>
      <li id=\"uk\">#{link_to 'UK', 'http://soulpad.co.uk'}</li>
      <li id=\"au\">#{link_to 'Australia', 'http://soulpad.com.au'}</li>"
		end
	end
end
