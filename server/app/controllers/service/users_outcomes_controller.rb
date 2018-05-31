module Service
  class UsersOutcomesController < ServiceController
    def index
      load_users_outcomes
      load_outcomes
      load_comments
    end

    private

    def load_users_outcomes
      @q = UsersOutcome.includes(:outcome).search(params[:q])
      users_outcomes = @q.result
                         .select('users_outcomes.outcome_id, users_outcomes.reaction, COUNT(*) AS cnt')
                         .group(:outcome_id, :reaction)
                         .order(:outcome_id, :reaction)
                         .to_a
      @users_outcomes = users_outcomes.group_by(&:outcome_id)
    end

    def load_outcomes
      @all_outcome_names = Outcome.select(:id, :name)
    end

    def load_comments
      all_comments = @q.result
      all_comments = all_comments.where.not(comment: nil) if params[:show_no_comment].present?
      comments = all_comments.includes(:user).order(id: :desc).limit(1000).to_a
      @comments = comments.group_by(&:outcome_id)
    end
  end
end
