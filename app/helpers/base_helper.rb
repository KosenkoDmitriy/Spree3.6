module BaseHelper

  def meta_data_tags

    Rails.logger.debug "@@@@@@@ Meta Data!"

    meta_keywords = if self.respond_to?(:object) && object && object.respond_to?(:meta_keywords) && object.meta_keywords.present?
                      object.meta_keywords
                    else
                      DynamicDatum.find_by_tag("meta_keywords").try(:data)
                    end

    meta_description = if self.respond_to?(:object) && object && object.respond_to?(:meta_description) && object.meta_description.present?
                         object.meta_description
                       else
                         DynamicDatum.find_by_tag("meta_description").try(:data)
                       end

    "".tap do |tags|
      tags << tag('meta', :name => 'keywords', :content => meta_keywords) + "\n" unless meta_keywords.blank?
      tags << tag('meta', :name => 'description', :content => meta_description) + "\n" unless meta_description.blank?
    end

  end

  def title_without_site_name
    title_string = @title.blank? ? accurate_title : @title

    if title_string.blank?
      default_title
    else
      title_string
    end
  end

	def exclude_taxon?(taxon)
		t(:excluded_taxons).include?(taxon.name)
	end

	def include_taxon?(taxon)
		t(:included_taxons).include?(taxon.name)
	end
end
