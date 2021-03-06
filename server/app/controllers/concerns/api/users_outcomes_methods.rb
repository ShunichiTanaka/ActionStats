module Api
  module UsersOutcomesMethods
    private

    def load_users_outcomes
      load_default_users_outcomes
      filter_users_outcomes_by_outcome_ids
      filter_users_outcomes_by_genders
      filter_users_outcomes_by_generations
    end

    def load_default_users_outcomes
      @users_outcomes = UsersOutcome.joins(:outcome, :user).where(post_date: @date, post_time: hour_range(@hour))
    end

    def filter_users_outcomes_by_outcome_ids
      outcome_ids = @user.users_outcomes.where(post_date: @date, post_time: hour_range(@hour)).pluck(:outcome_id)
      @users_outcomes = @users_outcomes.where(outcome_id: outcome_ids)
    end

    def filter_users_outcomes_by_genders
      return if params[:genders].blank?
      @users_outcomes = @users_outcomes.where(users: { gender: params[:genders] })
    end

    def filter_users_outcomes_by_generations
      return if params[:generations].blank?
      @users_outcomes = @users_outcomes.where(users: { year_of_birth: ages(params[:generations]) })
    end

    def load_data
      @data = { timing: hour_range_string(hour_range(@now.hour)) }
      @data[:genders]        = params[:genders]     if params[:genders].present?
      @data[:generations]    = params[:generations] if params[:generations].present?
      @data[:users_outcomes] = users_outcomes_json
    end

    def users_outcomes_json
      base_users_outcome_records.group_by(&:outcome_id).map do |outcome_id, grouped_records|
        total_count = grouped_records.sum(&:cnt)
        first_record = grouped_records.first
        {
          outcome_name: first_record.outcome_name,
          r: first_record.r_value,
          g: first_record.g_value,
          b: first_record.b_value,
          total_count:  total_count,
          reactions:    reactions(grouped_records, total_count),
          comments:     comments(outcome_id)
        }
      end
    end

    def base_users_outcome_records
      select_sql = [
        'outcomes.id AS outcome_id',
        'outcomes.name AS outcome_name',
        'outcomes.r_value',
        'outcomes.g_value',
        'outcomes.b_value',
        'users_outcomes.reaction',
        'COUNT(*) AS cnt'
      ].join(', ')
      @users_outcomes.select(select_sql)
                     .group('outcomes.id, users_outcomes.reaction')
                     .order('outcomes.display_order, users_outcomes.reaction')
                     .to_a
    end

    def reactions(grouped_records, total_count)
      grouped_records.map do |record|
        {
          reaction: record.reaction,
          percentage: format('%.1f', Rational(record.cnt * 100, total_count))
        }
      end
    end

    def comments(outcome_id)
      @users_outcomes.where(outcome_id: outcome_id)
                     .where.not(comment: nil)
                     .order(id: :desc)
                     .limit(30)
                     .map do |record|
        {
          generation: generation_by_age(record.user.age),
          gender:     record.user.gender_before_type_cast,
          prefecture: record.user.prefecture_i18n,
          reaction:   record.reaction,
          comment:    record.comment
        }
      end
    end
  end
end
