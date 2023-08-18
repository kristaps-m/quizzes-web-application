Rails.application.routes.draw do
    get '/', to: redirect('/quizzes')
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    get 'home', to: 'home#index'
    
    resources :quizzes do
        # get 'questions', on: :member
        resources :questions, except: [:index]
    end
end
