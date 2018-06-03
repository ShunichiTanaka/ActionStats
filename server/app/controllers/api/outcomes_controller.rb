module Api
  class OutcomesController < ApiController
    def index
      outcomes = Outcome.all
      response_data outcomes
    end
  end
end
