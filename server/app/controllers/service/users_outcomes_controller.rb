module Service
  class UsersOutcomesController < ServiceController
    def index
      load_users_outcomes
      @all_outcome_names = Outcome.pluck(:name, :id)
      @selected_outcomes = @q.outcome_id_eq.present? ? Outcome.where(id: @q.outcome_id_eq).limit(1) : Outcome.all
      @comments = @q.result.order(id: :desc)
    end

    private

    def load_users_outcomes
      @q = UsersOutcome.search(params[:q])
      @users_outcomes = @q.result
                          .select('users_outcomes.outcome_id, users_outcomes.reaction, COUNT(*) AS cnt')
                          .group(:outcome_id, :reaction)
                          .order(:outcome_id, :reaction)
    end
  end
end
