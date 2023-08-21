class QuestionsController < ApplicationController
  before_action :authorize_user, except: [:show]
  before_action :load_quiz
  before_action :load_question, except: %i[create new index]

  def index
    @questions = @quiz.questions.all
  end

  def show; end

  def new
    @question = @quiz.questions.new
  end

  def create
    @question = @quiz.questions.new(question_params)
    if @question.save
      redirect_to quiz_path(@quiz)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @question.update(question_params)
      redirect_to quiz_question_path(@quiz, @question)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @question.destroy
    redirect_to quiz_path(@quiz)
  end

  def questions
    render json: @question
  end

  private

  def load_quiz
    @quiz = Quiz.find(params[:quiz_id])
  end

  def authorize_user
    authorize! :manage, Question
  end

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:content, :answer)
  end
end
