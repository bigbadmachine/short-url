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

require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
