module Api
  # API共通コントローラ
  class ApiController < ApplicationController
    protect_from_forgery

    COMMON_STATUSES = {
      success:         0,
      system_error:    1,
      invalid_param:   2,
      unregistered:    3,
      already_reacted: 4,
      unreacted:       5
    }.freeze

    # リアクション
    PERMITTED_REACTIONS = [1, 2, 3, 4].freeze

    # 時間帯
    HOUR_RANGES = [
      0..2,
      3..5,
      6..8,
      9..11,
      12..14,
      15..17,
      18..20,
      21..23
    ].freeze

    class ApiError < StandardError; end

    # システムエラー
    rescue_from Exception, with: :handle_500 unless Rails.env.development?
    def handle_500(exception = nil)
      logger.error(exception.message) if exception
      response_error :system_error
    end

    # Not found
    rescue_from ActionController::RoutingError, ActiveRecord::RecordNotFound, with: :handle_404
    def handle_404
      response_error :system_error
    end

    # APIエラー
    rescue_from ApiError, with: :handle_api_error
    def handle_api_error
      response_error @api_error_key || :system_error
    end

    private

    def response_hash(hash)
      render json: hash
    end

    def response_success(data = nil)
      response_hash status: COMMON_STATUSES[:success], data: data
    end

    def response_error(key)
      response_hash status: COMMON_STATUSES[key]
    end

    def raise_api_error(key)
      @api_error_key = key
      raise ApiError
    end

    def load_user
      @user = User.find_by(identifier: params[:identifier])
      raise_api_error :unregistered unless @user
    end

    def load_time
      @now = Time.current
      @date = @now.to_date
      @hour = @now.hour
    end

    # すでにリアクション登録済か
    def already_reacted?
      load_user unless @user
      load_time unless @now
      UsersOutcome.exists?(post_date: @date, post_time: hour_range(@hour), user: @user)
    end

    # 現時刻が所属する時間帯を返す
    # 16時としたら 15..17 を返す
    def hour_range(hour = Time.current.hour)
      HOUR_RANGES.find { |range| hour.in? range }
    end

    def hour_range_string(range)
      min = format('%02d', range.min)
      max = format('%02d', range.max)
      "#{min}:00 - #{max}:59"
    end

    def ages(generations)
      generations.uniq.map(&method(:range_by_generation))
    end

    def range_by_generation(generation)
      this_year = @now.year
      int_generation = generation.to_i
      case int_generation
      when [20, 30, 40, 50]
        min = this_year - int_generation - 10
        max = this_year - int_generation - 1
        min..max
      when 10
        (this_year - 20)..this_year
      when 60
        0..(this_year - 61)
      else
        raise_api_error :invalid_param
      end
    end

    # 年齢から何十代か判定
    def generation_by_age(age)
      case age
      when 20..59
        age / 10 * 10
      when 0..19
        10
      else
        60
      end
    end
  end
end
