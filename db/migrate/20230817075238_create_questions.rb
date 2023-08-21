class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :content, null: false
      t.string :answer, null: false
      t.references :quiz, foreign_key: true

      t.timestamps
    end
  end
end
