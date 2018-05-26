module Seeds
  module Outcomes
    class << self
      include Seeds::Common

      def model
        Outcome
      end

      def column_names
        %i(category_id name)
      end
    end
  end
end
