class QuizStatistic < ApplicationRecord
  belongs_to :user
  belongs_to :quiz, foreign_key: :test_id, class_name: 'Quiz'

  # before_validation :set_user_id_if_not_logged_in
  
  # private

  # def set_user_id_if_not_logged_in
  #   self.user_id = current_user&.id || -1
  # end
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
