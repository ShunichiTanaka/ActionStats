module Seeds
  module Users
    class << self
      include Seeds::Common

      def model
        User
      end

      def column_names
        %i(gender year_of_birth prefecture registered_at)
      end
    end
  end
end
