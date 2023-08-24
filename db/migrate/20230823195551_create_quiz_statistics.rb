class CreateQuizStatistics < ActiveRecord::Migration[6.1]
  def change
    create_table :quiz_statistics do |t|
      t.integer :test_id
      t.string :test_title
      t.integer :creator_id
      t.string :creator_first_name
      t.string :creator_last_name
      t.string :creator_email
      t.datetime :quiz_take_date
      t.integer :correct_answers
      t.integer :total_questions

      t.timestamps
    end
  end
end
