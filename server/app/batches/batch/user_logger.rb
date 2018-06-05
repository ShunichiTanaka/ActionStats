# 使用方法
# 通常の場合
# bundle exec rails r "Batch::UserLogger.exec"
# リランの場合
# bundle exec rails r "Batch::UserLogger.exec(month: 7, day: 1)"
# bundle exec rails r "Batch::UserLogger.exec(year: 2018, month: 7, day: 1)"
module Batch
  class UserLogger < BatchBase
    def process(options)
      load_target_date(options)
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

    def user_base(gender)
      User.send(gender).where('users.registered_at <= ?', @target_date)
          .where('users.left_at > ? OR users.left_at IS NULL', @target_date)
    end

    def user_between_count(gender, target_year, min_age, max_age)
      user_base(gender).where('users.year_of_birth BETWEEN ? AND ?', target_year - max_age - 1, target_year - min_age - 1).count
    end

    def user_younger_count(gender, target_year, max_age)
      user_base(gender).where('users.year_of_birth >= ?', target_year - max_age - 1).count
    end

    def user_older_count(gender, target_year, min_age)
      user_base(gender).where('users.year_of_birth <= ?', target_year - min_age - 1).count
    end
  end
end
