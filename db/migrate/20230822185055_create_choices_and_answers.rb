class CreateChoicesAndAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table 'answer_choices', force: :cascade do |t|
      t.string 'content'
      t.boolean 'correct'
      t.references 'question'
      t.integer 'multiple_choice_question_id', null: false, index: true

      t.timestamps
    end

    create_table 'answers', force: :cascade do |t|
      t.references 'question'
      t.string 'content'
      t.boolean 'correct'
      t.timestamps
      t.string 'choice'
    end

    create_table 'choices', force: :cascade do |t|
      t.string 'content'
      t.boolean 'is_correct'
      t.references 'question'
      t.timestamps
    end

    create_table 'multiple_choice_questions', force: :cascade do |t|
      t.timestamps
      t.references 'quizz'
      t.string 'content'
      t.integer 'correct_choice_id'
    end

    add_column :questions, :question_type, :string
  end
end
