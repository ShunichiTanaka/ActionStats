module Seeds
  module Categories
    class << self
      include Seeds::Common

      def model
        Category
      end

      def column_names
        %i(name)
      end
    end
  end
end
