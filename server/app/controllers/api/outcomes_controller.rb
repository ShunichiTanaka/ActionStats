module Api
  # 選択可能アクション取得API
  class OutcomesController < ApiController
    def index
      raise_api_error :invalid_param if params[:identifier].blank?
      raise_api_error :already_reacted if already_reacted?

      response_success outcomes
    end

    private

    def outcomes
      Outcome.order(:display_order).map { |outcome| { name: outcome.name, id: outcome.id } }
    end
  end
end
