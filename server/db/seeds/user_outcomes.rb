module Seeds
  module UserOutcomes
    class << self
      GOOD_COMMENTS = %w[暖かい 涼しい 空いてる 楽しい 嬉しい 面白い].freeze
      BAD_COMMENTS = %w[暑い 寒い 混んでる 楽しくない だるい つまらない].freeze

      def exec
        ActiveRecord::Base.connection.execute('TRUNCATE TABLE users_outcomes')
        puts '==== START users_outcomes ===='
        9.downto(0) do |i| # 10日分
          post_date = i.days.ago.to_date
          puts "  #{post_date} 分作成"
          24.times do |j|
            rand(20).times do # 1時間に最大20件投稿
              user_outcome = UsersOutcome.new
              user_outcome_params(user_outcome, post_date, j)
              user_outcome.save
            end
          end
        end
        puts '==== END users_outcomes ===='
      end

      private

      def user_outcome_params(user_outcome, post_date, post_time)
        user_outcome.post_date = post_date
        user_outcome.post_time = post_time
        user_outcome.user_id = rand(1000) + 1
        user_outcome.outcome_id = rand(29) + 1
        reaction = rand(4) + 1
        user_outcome.reaction = reaction
        comment = reaction >= 3 ? GOOD_COMMENTS.sample : BAD_COMMENTS.sample
        user_outcome.comment = comment
      end
    end
  end
end
