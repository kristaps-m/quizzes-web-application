class QuizTakingController < ApplicationController
  before_action :load_quiz_and_questions, only: %i[take submit results]

  def take
    @current_question = @questions[@current_question_index]
  end

  def new
    @quiz_statistic = QuizStatistic.new
  end

  def submit
    user_answer = params[:user_answer]

    if user_answer.blank?
      flash[:alert] = 'Please choose or enter an answer before submitting.'
      redirect_to take_quiz_path(@quiz, current_question_index: @current_question_index)
    else
      @quiz_progression_handler.save_user_answer(@current_question, user_answer)
      redirect_to @quiz_progression_handler.next_question_path
    end
  end
def results
    @quiz = Quiz.find(params[:id])
    @score, @results = @quiz_progression_handler.calculate_score_and_results
    session[:quiz_score] = @score
  end

  private

  def load_quiz_and_questions
    @quiz = Quiz.find(params[:id])
    @questions = @quiz.questions
    @current_question_index = params[:current_question_index].to_i
    @current_question = @questions[@current_question_index]
    session["quiz#{params[:id]}_user_answers"] ||= {}
    @quiz_progression_handler = QuizProgressionHandler.new(params[:id], @current_question_index,
                                                           session["quiz#{params[:id]}_user_answers"], self)
  end

  def proceed_to_next_question
    if @current_question_index == @questions.length - 1
      session[:quiz_score] = calculate_score
      save_quiz_statistic if user_signed_in?
      redirect_to quiz_results_path(@quiz)
    else
      redirect_to take_quiz_path(@quiz, current_question_index: @current_question_index + 1)
    end
  end

  def save_quiz_statistic
    quiz_statistic = QuizStatistic.new(
      test_id: @quiz.id,
      creator_id: @quiz.creator.id,
      correct_answers: results.count { |result| result[:correct] == true },
      total_questions: @questions.length,
      quiz_finisher_id: current_user.id,
      user_id: current_user.id
    )

    if quiz_statistic.save
      flash[:success] = 'Quiz statistic saved successfully!'
    else
      flash[:alert] = 'Failed to save quiz statistic'
    end
  end
end
