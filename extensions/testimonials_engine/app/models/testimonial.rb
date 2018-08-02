class Testimonial < ActiveRecord::Base

	attr_accessible :name, :body, :enabled
  scope :enabled, -> { where(enabled: true) }

  def yesno
    enabled ? 'Yes' : 'No'
  end

end