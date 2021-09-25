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
#  typed: ignore

require 'rails_helper'

RSpec.describe Link, type: :model do
  it { is_expected.to validate_presence_of(:url) }
  it { is_expected.to allow_value('https://example.com/winterfall').for(:url) }
  it { is_expected.not_to allow_value('example.com/').for(:url) }

  it { is_expected.to validate_uniqueness_of(:slug) }
  it { is_expected.to allow_value('uildn').for(:slug) }
  it { is_expected.not_to allow_value('99nhkl').for(:slug) }
end
