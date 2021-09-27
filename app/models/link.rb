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
  has_many :clicks

  before_create :set_slug

  validates :url, presence: true
  validates :url, format: { with: VALID_URL_REGEX }
  validates :slug, uniqueness: true, length: { maximum: 9 }

  def shortener
    return "https://shortenurlbe.herokuapp.com/#{slug}" if Rails.env.production?

    "http://localhost:3000/#{slug}"
  end

  def set_slug
    self.slug = ([*('A'..'Z'), *('a'..'z'), *('0'..'9')] - %w[0 1 I O]).sample(9).join
  end
end
