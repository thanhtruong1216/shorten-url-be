class ApiKey < ApplicationRecord
  belongs_to :user
  before_create :set_token

  def set_token
    self.token ||= SecureRandom.hex
  end
end
