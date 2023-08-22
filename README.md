# grupa-4

# User Authentication (Devise):
gem 'devise'

User:
  first_name :string
  last_name  :string
  email      :string 
  is_admin   :boolean

  Ability to register as new User with name, lastname, email and password.
  Ability to edit profile name, lastname, email, password and delete profile.
  Users can create quizzes.
  Users can see CRUD buttons for only those quizzes which they have created.
  If user has admin profile (user.is_admin = true) he can CRUD all quizzes.
