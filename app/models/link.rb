# frozen_string_literal: true

# == Schema Information
#
# Table name: links
#
#  id         :bigint           not null, primary key
#  url        :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Link < ApplicationRecord
  before_save :set_slug

  validates_presence_of :url
  validates :url, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
  validates_uniqueness_of :slug

  private

  def shortener
    "http://localhost:3000/#{slug}" if Rails.env.development?
  end

  def set_slug
    self.slug = ([*('A'..'Z'), *('a'..'z'), *('0'..'9')] - %w[0 1 I O]).sample(5).join
  end
end
