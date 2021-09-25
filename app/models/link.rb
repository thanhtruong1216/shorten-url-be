# frozen_string_literal: true

# == Schema Information
#
# Table name: links
#
#  id         :bigint           not null, primary key
#  url        :string           not null
#  slug       :string
#  user_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Link < ApplicationRecord
  include CustomValidators

  belongs_to :user

  before_create :set_slug

  validates :url, presence: true
  validates :url, format: { with: VALID_URL_REGEX }
  validates :slug, uniqueness: true, length: { maximum: 9 }

  def shortener
    "http://localhost:3000/#{slug}" if Rails.env.development?
  end

  def set_slug
    self.slug = ([*('A'..'Z'), *('a'..'z'), *('0'..'9')] - %w[0 1 I O]).sample(9).join
  end
end
