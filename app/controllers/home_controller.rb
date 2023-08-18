class HomeController < ApplicationController
    def index
        render json: :ok
    end
end