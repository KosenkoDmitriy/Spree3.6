class Post < ActiveRecord::Base

	POST_TYPES = {
		:news => "News",
		:articles => "Articles",
		:faqs => "FAQs"
	}

	def self.per_page
	  1
  end

	scope :news, -> { where(post_type: POST_TYPES[:news]) }
	scope :articles, -> { where(post_type: POST_TYPES[:articles]) }
	scope :faqs, -> { where(post_type: POST_TYPES[:faqs]) }

	scope :published, -> { where(["posts.published_on <= ?", Time.current]) }
	scope :unpublished, -> { where(["posts.published_on IS NULL OR posts.published_on > ?", Time.current]) }

	validates_presence_of :title, :message => "can't be blank"
	validates_presence_of :permalink, :message => "can't be blank"

	# make_permalink

	def to_param
		self.permalink || self.title.parameterize
	end

	def permalink= v
		write_attribute :permalink, v.parameterize
	end

  def unpublish!
    self.published_on = nil
    self.save
  end

	def published?
		published_on && published_on <= Date.current
	end

	def news?
		self.post_type == "News"
	end

	def articles?
		self.post_type == "Articles"
	end

	def faq?
		self.post_type == "FAQs"
	end

end
