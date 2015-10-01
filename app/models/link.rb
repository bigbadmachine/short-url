# == Schema Information
#
# Table name: links
#
#  id         :integer          not null, primary key
#  token      :string(10)       not null
#  url        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Link < ActiveRecord::Base
  before_validation :generate_token
  
  validates :url, presence: true
  validate :valid_url
  
  validates :token, presence: true, uniqueness: true

  private
    def generate_token
      self.token = LinkShortener.generate if token.blank?
    end

    def valid_url
      unless url =~ LinkShortener::REGEX_VALID_URL
        errors.add(:url, "must be in a valid format(eg. http://bbmdev.com)")
      end
    end
end
