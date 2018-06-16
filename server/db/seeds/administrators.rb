module Seeds
  module Administrators
    class << self
      include Seeds::Common

      def model
        Administrator
      end

      def column_names
        %i(email password)
      end
    end
  end
end
