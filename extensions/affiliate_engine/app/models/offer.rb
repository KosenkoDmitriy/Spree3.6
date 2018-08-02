class Offer < ActiveRecord::Base
  attr_accessible :slug, :contact_tel, :address, :latitude, :longitude, :postcode, :offer, :title, :location, :contact_email, :enabled, :view_by_appt, :description, :image, :website, :offer_images_attributes

  has_many :offer_images, :dependent => :destroy

  accepts_nested_attributes_for :offer_images, :reject_if => proc { |attributes|attributes['image'].blank? }, :allow_destroy => true

  validates_presence_of :contact_tel
  validates_presence_of :title
  validates_presence_of :location
  validates_presence_of :postcode
  validates_presence_of :contact_email
  validates_presence_of :description
  validates_presence_of :website
  validates_presence_of :slug

  scope :enabled, -> { where(enabled: true) }

  geocoded_by :postcode
  after_validation :geocode

  def description_text
    ActionView::Base.full_sanitizer.sanitize(self.description)
  end

  def image_visible?
    self.offer_images.size > 0 ? true : false
  end

private

  before_validation do
    self.slug = title.downcase.gsub(" ", "-")
  end

end
