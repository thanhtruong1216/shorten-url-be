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
require "test_helper"

class LinkTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
