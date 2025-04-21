# Grupa 4

# To start project

- CLONE it OR Download .Zip file
- open terminal in main folder (quizzes-web-application)

- 1. bundle install
- 2. npm install
- 3. rails db:create db:migrate db:seed
- 4. rails s
- 5. Visit the app: Open http://localhost:3000 in your browser.

# Exmaples

<img src="_readme pictures/bundle.png">

`npm install`

<img src="_readme pictures/create_db_and_migrate.png">

<img src="_readme pictures/rails_s.png">

<img src="_readme pictures/webpacker_error.png">

For newer Node you might run into problems :(

Running into a common issue with Webpacker + Node 17+ and newer (especially Node 18+ and 20+). The key line here is:

Error: error:0308010C:digital envelope routines::unsupported

This happens because Node.js 17 and above changed how OpenSSL works, and Webpack 4 (used by Webpacker 5 in Rails 6) doesn’t support those changes.

<img src="_readme pictures/webpacker_error_fixer.png">

# Quiz Management Web Application

Welcome to the Quiz Management Web Application! This Ruby on Rails-based application allows users to create, take, and manage quizzes. Whether you're a quiz enthusiast or an educator looking for an interactive platform, this application has you covered.

<table>
  <tr>
    <th>Table of Quizzes / Statistics</th>
    <th>Single answer question / Multiple answer question</th>
  </tr>
  <tr>
    <td><img src="_readme pictures/quizzes_index.png" width="400"></td>
    <td><img src="_readme pictures/question.png" width="400"></td>
  </tr>
  <tr>
    <td><img src="_readme pictures/stats_index.png" width="400"></td>
    <td><img src="_readme pictures/question_m.png" width="400"></td>

  </tr>
</table>

## Features

### 1. User Authentication

- Users can sign up for an account or log in with their existing credentials.
- User profiles are securely managed with Devise for authentication.

### 2. Quiz Creation and Management

- Users can create quizzes with titles and descriptions.
- Quizzes can include images to make them visually appealing.
- Questions can be added to quizzes with content and answer options.
- Questions can have multiple-choice or single-answer formats.

### 3. Quiz Taking

- Users can take quizzes in an interactive manner.
- For multiple-choice questions, users can choose their answers.
- For single-answer questions, users can provide their responses.

### 4. Quiz Statistics

- Users can view detailed statistics for each quiz they take.
- Statistics include scores, correctness, and individual question performance.

### 5. Admin Panel

- Admin users have special privileges to manage all quizzes and questions.
- This includes editing, deleting, or creating new quizzes and questions.

## Key Components

### Controllers

- `QuestionsController`: Manages questions associated with quizzes.
- `QuizStatisticsController`: Handles quiz statistics, including scores and results.
- `QuizTakingController`: Controls the quiz-taking process and results display.
- `QuizzesController`: Manages quizzes and their associated questions.

### Models

- `Ability`: Defines user permissions and abilities using CanCanCan.
- `Answer`: Represents answer choices for multiple-choice questions.
- `Question`: Represents quiz questions and their answers.
- `QuizStatistic`: Stores statistics related to quiz performance.
- `Quiz`: Represents quizzes, which consist of questions.
- `User`: Represents user accounts.

### Views

- Views correspond to various actions in the controllers and render the user interface for interaction.

### Authentication and Authorization

- User authentication is handled by Devise, allowing users to securely register and log in.
- Authorization is implemented using CanCanCan, allowing or denying access to actions based on user roles and permissions.
