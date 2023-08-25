class Quiz < ApplicationRecord
    has_many :questions, dependent: :destroy
    belongs_to :creator, class_name: "User", foreign_key: "user_id"

    has_one_attached :image
    attr_accessor :remove_image
    
    validates :title, presence: true, uniqueness: true, length: { minimum: 3 }
    accepts_nested_attributes_for :questions, allow_destroy: true, reject_if: :all_blank

    def question_count
      questions.count
    end
end

# == Schema Information
#
# Table name: quizzes
#
#  id          :integer          not null, primary key
#  description :string
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#
# Indexes
#
#  index_quizzes_on_title    (title) UNIQUE
#  index_quizzes_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
