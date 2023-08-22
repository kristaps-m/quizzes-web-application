class AddChoiceToAnswers < ActiveRecord::Migration[6.1]
  def change
    add_column :answers, :choice, :string
  end
end
