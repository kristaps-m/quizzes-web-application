# == Schema Information
#
# Table name: quiz_statistics
#
#  id               :integer          not null, primary key
#  correct_answers  :integer
#  total_questions  :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  creator_id       :integer
#  quiz_finisher_id :integer
#  test_id          :integer
#  user_id          :integer
#
# Indexes
#
#  index_quiz_statistics_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
require "test_helper"

class QuizStatisticTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
