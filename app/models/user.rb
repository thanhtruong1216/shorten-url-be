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
class User < ApplicationRecord
  include CustomValidators

  has_many :links

  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: VALID_EMAIL_REGEX }
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }
end
