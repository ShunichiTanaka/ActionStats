module Batch
  class BatchBase
    class << self
      def exec
        new.process
      rescue StandardError => e
        Rails.logger.error e.class
        Rails.logger.error e.backtrace
        Rails.logger.error e.message
      end
    end

    def process
      raise NoMethodError, 'This method must be overridden.'
    end
  end
end
