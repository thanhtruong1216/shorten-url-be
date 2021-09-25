# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  name            :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to allow_value('winterfall@gmail.com').for(:email) }
  it { is_expected.not_to allow_value('bluesky.com').for(:email) }

  it { is_expected.to allow_value('123abc@#$').for(:password) }
  it { is_expected.not_to allow_value('12345').for(:password) }
end
