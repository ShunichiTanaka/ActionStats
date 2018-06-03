module Api
  class OutcomesController < ApplicationController
    def index
      outcomes = Outcome.all
      render json: { staus: 200, data: outcomes }
    end
  end
end
