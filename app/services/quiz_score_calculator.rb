class QuizScoreCalculator
  def initialize(quiz, user_answers)
    @quiz = quiz
    @user_answers = user_answers
  end
  def calculate
    score = 0
    results = []
    @quiz.questions.each do |question|
      user_answer = @user_answers["q#{question.id}_answer"]
      if question.question_type == 'Multiple Choice'
        correct_choices = question.answers.select(&:correct?).pluck(:choice)
        user_choices = user_answer.is_a?(Array) ? user_answer : [user_answer]
        if (correct_choices - user_choices).empty? && (user_choices - correct_choices).empty?
          score += 1
          results << { question: question, correct: true }
        else
           results << { question: question, correct: false }
         end
       elsif question.question_type == 'Single Answer'
         user_answer = user_answer.upcase
         correct_answer = question.answer.upcase

         if user_answer == correct_answer
           score += 1
           results << { question: question, correct: true }
         else
          results << { question: question, correct: false }
        end
      end
    end
    [score, results]
  end
end