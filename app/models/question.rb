class Question < ApplicationRecord
    belongs_to :quiz
    has_many :answers, dependent: :destroy
    accepts_nested_attributes_for :answers
    validates :content, presence: true, uniqueness: { scope: :quiz_id }, length: { minimum: 3 }
    validates :answer, presence: true, if: -> { question_type == 'Single Answer' }
end

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
