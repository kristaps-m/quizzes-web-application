class CreateQuizzes < ActiveRecord::Migration[6.1]
  def change
    create_table :quizzes do |t|
        t.string :title, null: false, index: { unique: true }
        t.timestamps
    end
  end
end
