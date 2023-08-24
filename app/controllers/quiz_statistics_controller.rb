class QuizStatisticsController < ApplicationController
  before_action :authenticate_user!

  def index
    @quiz_statistics = current_user.quiz_statistics
  end

  # def new
  #   @quiz_statistic = QuizStatistic.new
  # end

  def create
    # @quiz_statistic = current_user.quiz_statistics.new(quiz_statistic_params)
    @quiz_statistic = QuizStatistic.new(quiz_statistic_params)
    if @quiz_statistic.save
      # flash.notice = "Quiz statistic saved successfully!"
      # redirect_to quiz_statistics_path
      redirect_to @quiz_statistic, notice: 'Quiz statistic saved successfully!'
    else
      flash.now.alert = "Failed to save quiz statistic"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def quiz_statistic_params
    params.require(:quiz_statistic).permit(:test_id, :creator_id, :quiz_take_date, :correct_answers, :total_questions)
  end
end
