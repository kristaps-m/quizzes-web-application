class QuizzesController < ApplicationController
  before_action :authorize_user, except: %i[index show]
  before_action :load_quiz, except: %i[index create new]

  def index
    @quizzes = Quiz.all
  end

  def show; end

  def new
    @quiz = Quiz.new
  end

  def create
    @quiz = current_user.quizzes.new(quiz_params)

    if @quiz.save
      flash[:success] = 'Hooray! You did it!'
      redirect_to @quiz
    else
      flash[:alert] = 'Sorry, something went wrong..'
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if params[:add_question]
      @quiz.assign_attributes(quiz_params)
      @quiz.questions.build
      render :edit, status: :ok
    elsif @quiz.update(quiz_params)
      @quiz.image.purge if params.dig(:quiz, :remove_image) == '1'
      update_answers
      redirect_to @quiz
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @quiz.destroy
    redirect_to quizzes_path
  end

  def questions
    render json: @quiz.questions
  end

  private

  def load_quiz
    @quiz = Quiz.find(params[:id])
  end

  def authorize_user
    authorize! :manage, Quiz
  end

  def quiz_params
    params.require(:quiz).permit(
      :title,
      :description,
      :image,
      questions_attributes: [
        :id,
        :content,
        :answer,
        :question_type,
        :_destroy,
        answers_attributes: [:id, :choice, :correct, :_destroy]
      ]
    )
  end

  def update_answers
    @quiz.questions.each do |question|
      next unless question.question_type == 'Multiple Choice'

      question.answers.each do |answer|
        answer_params = params.dig(:quiz, :questions_attributes, question.id.to_s, :answers_attributes, answer.id.to_s)
        answer.update(answer_params) if answer_params
      end
    end
  end
end
