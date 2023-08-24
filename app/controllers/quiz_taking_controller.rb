class QuizTakingController < ApplicationController
  before_action :load_quiz_and_questions, only: %i[take submit results]

  def take
    @current_question = @questions[@current_question_index]
  end

  def submit
    user_answer = params[:user_answer]

    if user_answer.blank?
      flash[:alert] = 'Please choose or enter an answer before submitting.'
    else
      @quiz_progression_handler.save_user_answer(@current_question, user_answer)
    end

    redirect_to @quiz_progression_handler.next_question_path
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
  session["quiz_#{params[:id]}_user_answers"] ||= {}
  @quiz_progression_handler = QuizProgressionHandler.new(params[:id], @current_question_index, session["quiz_#{params[:id]}_user_answers"], self)
end
end
