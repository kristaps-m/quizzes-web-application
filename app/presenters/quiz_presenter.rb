class QuizPresenter
    def initialize(quiz)
      @quiz = quiz
    end
  
    def created_at
      @quiz.created_at.strftime('Created: %m/%d/%Y')   
    end
  end