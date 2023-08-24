class AddUserIdToQuizStatistics < ActiveRecord::Migration[6.1]
  def change
    add_reference :quiz_statistics, :user, foreign_key: true
  end
end
