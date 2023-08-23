# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  choice      :string
#  content     :string
#  correct     :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :integer
#
# Indexes
#
#  index_answers_on_question_id  (question_id)
#
require "test_helper"

class AnswerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
