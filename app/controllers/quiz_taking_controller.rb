class QuizTakingController < ApplicationController
  def take
    @quiz = Quiz.find(params[:id])
    @questions = @quiz.questions
    @user_answers = {}
  end

  def submit
    @quiz = Quiz.find(params[:id])
    @questions = @quiz.questions
    @user_answers = params[:user_answers]
    @score = 0
    all_fields_filled = true

    @questions.each do |question|
      user_answer = @user_answers["q#{question.id}_answer"]
      if user_answer == question.answer
        @score += 1
      elsif user_answer.blank?
        all_fields_filled = false
        flash[:alert] = 'Please answer all questions before submitting.'
        break
      end
    end

    if all_fields_filled
      session[:quiz_score] = @score
      redirect_to quiz_results_path(@quiz)
    else
      render :take
    end
  end

  def results
    @quiz = Quiz.find(params[:id])
    @score = session[:quiz_score]
  end
end