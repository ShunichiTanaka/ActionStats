# 使用方法
# bundle exec rails r "Batch::UserLogger.exec"
module Batch
  class UserLogger < BatchBase
    def process(target_date = Time.current.to_date)
      @target_date = target_date
      @user_log = UserLog.new
      set_data
      @user_log.save
    end

    private

    def set_data
      @user_log.target_date = @target_date
      target_year = @target_date.year
      %i[male female].each do |gender|
        @user_log.send "#{gender}_10=", user_younger_count(gender, target_year, 19)
        (2..5).each do |i|
          @user_log.send "#{gender}_#{i}0=", user_between_count(gender, target_year, i * 10, i * 10 + 9)
        end
        @user_log.send "#{gender}_60=", user_older_count(gender, target_year, 60)
      end
    end

    def user_between_count(gender, target_year, min_age, max_age)
      User.send(gender).where('users.year_of_birth BETWEEN ? AND ?', target_year - max_age - 1, target_year - min_age - 1).count
    end

    def user_younger_count(gender, target_year, max_age)
      User.send(gender).where('users.year_of_birth >= ?', target_year - max_age - 1).count
    end

    def user_older_count(gender, target_year, min_age)
      User.send(gender).where('users.year_of_birth <= ?', target_year - min_age - 1).count
    end
  end
end
