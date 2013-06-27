require 'uri'

class Url < ActiveRecord::Base

  belongs_to :user

    validates_format_of :full_url, { with: URI::regexp(%w(http https)), message:"must be a valid url"}
    before_save :generate_short_url

    def generate_short_url
      self.short_url = SecureRandom.base64(5)
    end

    def update_counter
      self.counter += 1
      self.save
    end
end
