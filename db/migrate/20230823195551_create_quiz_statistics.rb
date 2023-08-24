class CreateQuizStatistics < ActiveRecord::Migration[6.1]
  def change
    create_table :quiz_statistics do |t|
      t.integer :test_id
      t.integer :creator_id
      t.integer :correct_answers
      t.integer :total_questions
      t.integer :quiz_finisher_id

      t.timestamps
    end
  end
end
