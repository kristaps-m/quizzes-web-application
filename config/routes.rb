Rails.application.routes.draw do
  # devise_for :users # this was before modification about quizzes stay after user deleted
  devise_for :users, controllers: { # user now can be deleted quizzes stays?
    registrations: 'users/registrations'
  }

  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end
  get '/', to: redirect('/quizzes')

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'home', to: 'home#index'

  resources :quiz_statistics, only: [:index, :create]

  resources :quizzes do
    resources :questions, except: [:index]

    member do
      get 'take', to: 'quiz_taking#take'
      post 'submit', to: 'quiz_taking#submit'
      get 'results', to: 'quiz_taking#results'
    end
  end

  get 'quizzes/:id/results', to: 'quiz_taking#results', as: 'quiz_results'
end
