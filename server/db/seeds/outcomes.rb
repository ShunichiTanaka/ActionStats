module Seeds
  module Outcomes
    class << self
      include Seeds::Common

      def model
        Outcome
      end

      def column_names
        %i(category_id name r_value g_value b_value)
      end
    end
  end
end
