class QuizzesController < ApplicationController
    before_action :authorize_user, except: [:index, :show] # Added because of authenticate!
    before_action :load_quiz, except: [:index, :create, :new]
  
    def index
      @quizzes = Quiz.all
    end

    def show
    end

    def new
        @quiz = Quiz.new
    end

    def create
        @quiz = Quiz.new(quiz_params)
        if @quiz.save
            redirect_to @quiz, notice: 'Hooray! You did it!'
        else
            flash.now.alert = 'Sorry, something went wrong..'
            render :new, status: :unprocessable_entity
        end
    end

    def edit
    end

    def update
        if params[:add_question]
          @quiz.assign_attributes(quiz_params)
          @quiz.questions.build
          render :edit, status: 200
        else
          if @quiz.update(quiz_params)
            if params[:quiz][:remove_image] == '1'
              @quiz.image.purge
            end
            redirect_to @quiz
          else
            render :edit, status: :unprocessable_entity
          end
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
        params.require(:quiz).permit(:title, :description, :image, questions_attributes: [:content, :answer, :id, :_destroy])
    end
end
