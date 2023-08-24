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

  def proceed_to_next_question
    if @current_question_index == @questions.length - 1
      session[:quiz_score] = calculate_score
      if user_signed_in? # Check if the user is logged in
        save_quiz_statistic # Call the method to save the quiz statistic
      end
      redirect_to quiz_results_path(@quiz)
    else
      redirect_to take_quiz_path(@quiz, current_question_index: @current_question_index + 1)
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
