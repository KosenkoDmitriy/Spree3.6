class OfferImage < ActiveRecord::Base
  belongs_to :offer
  has_attached_file :image,
                    :styles => { :thumb => "100x100#",
                                 :small => "200x200#",
                                 :large => "650x650>"},

                    :convert_options => {:thumb => "-quality 75 -strip",
                                         :small => "-quality 75 -strip",
                                         :medium => "-quality 80 -strip",
                                         :large => "-quality 90 -strip" },

                    :storage => :fog,
                    :fog_credentials => {
                        :aws_access_key_id => ENV['AWS_ACCESS_KEY_ID'],
                        :aws_secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
                        :provider => 'AWS',
                        :region => 'us-east-1',
                        :scheme => 'https',
                    },
                    :fog_directory => ENV['S3_BUCKET'],
                    :fog_public => true,
                    :default_url => "/images/:style/missing.png",
                    :path => ":attachment/:id/:style.:extension"

  validates_presence_of :image
  validates_attachment_size :image, :less_than => 1.megabytes

  def upload_from_url(url)
    self.image = URI.parse(url)
  end
end
