class QuizProgressionHandler
  attr_accessor :controller_context

  def initialize(quiz_id, current_question_index, user_answers, controller_context)
    @quiz = Quiz.find(quiz_id)
    @current_question_index = current_question_index
    @user_answers = user_answers || {}
    @controller_context = controller_context
  end

  def next_question_path
    if @current_question_index == @quiz.questions.length - 1
      controller_context.quiz_results_path(@quiz)
    else
      controller_context.take_quiz_path(@quiz, current_question_index: @current_question_index + 1)
    end
  end

  def save_user_answer(question, answer)
    @user_answers["q#{question.id}_answer"] = answer
  end

  def calculate_score_and_results
    calculator = QuizScoreCalculator.new(@quiz, @user_answers)
    calculator.calculate
  end
end
