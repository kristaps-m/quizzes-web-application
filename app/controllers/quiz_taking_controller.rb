class QuizTakingController < ApplicationController
  before_action :load_quiz_and_questions, only: %i[take submit]

  def take
    @current_question = @questions[@current_question_index]
  end

  def submit
    user_answer = params[:user_answer]
    save_user_answer(@current_question, user_answer)

    if user_answer.blank?
      flash[:alert] = 'Please enter an answer before submitting.'
      redirect_to take_quiz_path(@quiz, current_question_index: @current_question_index)
    elsif @current_question_index == @questions.length - 1
      session[:quiz_score] = calculate_score
      redirect_to quiz_results_path(@quiz)
    else
      redirect_to take_quiz_path(@quiz, current_question_index: @current_question_index + 1)
    end
  end

  def results
    @quiz = Quiz.find(params[:id])
    @score = session[:quiz_score]
    @results = calculate_score
  end

  private

  def load_quiz_and_questions
    @quiz = Quiz.find(params[:id])
    @questions = @quiz.questions
    @current_question_index = params[:current_question_index].to_i
    @current_question = @questions[@current_question_index]
  end

  def save_user_answer(question, answer)
    session["quiz_#{params[:id]}_user_answers"] ||= {}
    session["quiz_#{params[:id]}_user_answers"]["q#{question.id}_answer"] = answer
  end

  def calculate_score
    user_answers = session["quiz_#{params[:id]}_user_answers"]
    @questions = @quiz.questions
    score = 0
    results = []

    @questions.each do |question|
      user_answer = user_answers["q#{question.id}_answer"]
      if user_answer == question.answer
        score += 1
        results << { question: question, correct: true }
      else
        results << { question: question, correct: false }
      end
    end

    session[:quiz_score] = score
    results
  end
end