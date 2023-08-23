# == Schema Information
#
# Table name: questions
#
#  id            :integer          not null, primary key
#  answer        :string           not null
#  content       :string           not null
#  question_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  quiz_id       :integer
#
# Indexes
#
#  index_questions_on_quiz_id  (quiz_id)
#
# Foreign Keys
#
#  quiz_id  (quiz_id => quizzes.id)
#
require "test_helper"

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
