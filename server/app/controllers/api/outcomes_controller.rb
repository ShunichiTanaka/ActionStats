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
      Outcome.order(:display_order).map do |outcome|
        { name: outcome.name, id: outcome.id, r: outcome.r_value, g: outcome.g_value, b: outcome.b_value }
      end
    end
  end
end
