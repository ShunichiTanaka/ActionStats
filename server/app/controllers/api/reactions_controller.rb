module Api
  # リアクション登録API
  class ReactionsController < ApiController
    include Api::UsersOutcomesMethods

    def create
      raise_api_error :invalid_param unless valid_params?
      raise_api_error :already_reacted if already_reacted?
      load_time
      post_reactions
      load_users_outcomes
      load_data
      response_success @data
    end

    private

    def valid_params?
      return false if params[:identifier].blank?
      return false if params[:outcomes].blank?
      outcome_ids = Outcome.pluck(:id)
      params[:outcomes].each do |outcome|
        return false unless outcome[:id].in? outcome_ids
        return false if outcome[:reaction].blank?
      end
      true
    rescue StandardError
      false
    end

    def post_reactions
      ApplicationRecord.transaction do
        params[:outcomes].each do |outcome|
          users_outcome = UsersOutcome.new
          users_outcome.user       = @user
          users_outcome.post_date  = @date
          users_outcome.post_time  = @hour
          users_outcome.outcome_id = outcome[:id]
          users_outcome.reaction   = outcome[:reaction]
          users_outcome.comment    = outcome[:comment].presence
          raise_api_error :invalid_param unless users_outcome.save
        end
      end
    end
  end
end
