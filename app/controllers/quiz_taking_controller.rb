class QuizTakingController < ApplicationController
  before_action :load_quiz_and_questions, only: %i[take submit]

  def take
    @current_question = @questions[@current_question_index]
  end

  def new
    @quiz_statistic = QuizStatistic.new
  end

  def submit
    user_answer = params[:user_answer]

    if @current_question.question_type == 'Multiple Choice'
      selected_answers = Array(user_answer).reject(&:blank?)

      if selected_answers.empty?
        flash[:alert] = 'Please choose at least one answer before submitting.'
      else
        correct_answers = @current_question.answers.select(&:correct?).pluck
      end
    elsif @current_question.question_type == 'Single Answer'
      if user_answer.blank?
        flash[:alert] = 'Please enter an answer before submitting.'
      else
        correct_answer = @current_question.answers.find_by(correct: true)&.choice
      end
    end
    save_user_answer(@current_question, user_answer)
    proceed_to_next_question
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
    puts "Question Type: #{@current_question.question_type}"
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
        if user_answer == question.answer
          score += 1
          results << { question: question, correct: true }
        else
          results << { question: question, correct: false }
        end
      end
    end

    session[:quiz_score] = score
    results
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

  def save_quiz_statistic
    # Logic to save quiz statistics to the database
    quiz_statistic = QuizStatistic.new(
      test_id: @quiz.id,
      creator_id: @quiz.creator.id,
      correct_answers: session[:quiz_score],
      total_questions: @questions.length,
      quiz_finisher_id: current_user.id,
      user_id: current_user.id
    )
  
    if quiz_statistic.save
      # Optionally, you can add a flash message here
      flash[:alert] = 'Quiz statistic saved successfully!'
    else
      flash[:alert] = "Failed to save quiz statistic"
    end
  end
  
end
