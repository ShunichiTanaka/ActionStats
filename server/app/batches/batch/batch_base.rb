module Batch
  class BatchBase
    class << self
      def exec(options = {})
        new.process(options)
      rescue StandardError => e
        Rails.logger.error e.class
        Rails.logger.error e.backtrace
        Rails.logger.error e.message
      end
    end

    def process(_options)
      raise NoMethodError, 'This method must be overridden.'
    end

    private

    def load_target_date(options)
      today = Time.current.to_date
      year  = options[:year]  || today.year
      month = options[:month] || today.month
      day   = options[:day]   || today.day
      @target_date = Date.new(year, month, day)
    rescue StandardError
      @target_date = today
    end
  end
end
