module Api
  # 結果絞り込みAPI
  class UsersOutcomesController < ApiController
    include Api::UsersOutcomesMethods

    def index
      raise_api_error :invalid_param if params[:identifier].blank?
      raise_api_error :unreacted unless already_reacted?
      load_time
      load_users_outcomes
      load_data
      response_success @data
    end
  end
end
