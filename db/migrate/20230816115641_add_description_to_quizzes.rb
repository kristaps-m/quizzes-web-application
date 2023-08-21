class AddDescriptionToQuizzes < ActiveRecord::Migration[6.1]
  def change
    add_column :quizzes, :description, :string
  end
end
