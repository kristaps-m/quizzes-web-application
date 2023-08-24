class QuizStatistic < ApplicationRecord
end

# == Schema Information
#
# Table name: quiz_statistics
#
#  id                 :integer          not null, primary key
#  correct_answers    :integer
#  creator_email      :string
#  creator_first_name :string
#  creator_last_name  :string
#  quiz_take_date     :datetime
#  test_title         :string
#  total_questions    :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  creator_id         :integer
#  test_id            :integer
#
