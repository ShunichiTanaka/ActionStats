module Service
  class UsersOutcomesController < ServiceController
    def index
      load_users_outcomes
      @all_outcome_names = Outcome.all
      @selected_outcomes = @q.outcome_id_in.present? ? Outcome.where(id: @q.outcome_id_in) : @all_outcome_names
      load_comments
    end

    private

    def load_users_outcomes
      @q = UsersOutcome.search(params[:q])
      @users_outcomes = @q.result
                          .select('users_outcomes.outcome_id, users_outcomes.reaction, COUNT(*) AS cnt')
                          .group(:outcome_id, :reaction)
                          .order(:outcome_id, :reaction)
    end

    def load_comments
      all_comments = @q.result
      all_comments = all_comments.where.not(comment: nil) if params[:show_no_comment].present?
      @comments = all_comments.order(id: :desc).limit(1000)
    end
  end
end
