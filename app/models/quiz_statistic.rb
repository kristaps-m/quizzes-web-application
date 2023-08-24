class QuizStatistic < ApplicationRecord
end

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
#
