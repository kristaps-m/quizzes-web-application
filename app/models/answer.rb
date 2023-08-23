class Answer < ApplicationRecord
  belongs_to :question
  validates :choice, presence: true
end

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
