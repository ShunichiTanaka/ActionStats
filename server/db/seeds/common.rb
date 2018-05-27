module Seeds
  module Common
    def exec
      puts "==== START #{model.table_name} ===="
      CSV.foreach("db/seeds/csvs/#{model.table_name}.csv").with_index(1) do |row, id|
        next puts "   exist  #{id}" if model.find_by(id: id)
        puts "  create  #{id}: #{row[0]}"
        model.create! data_hash(row).merge(id: id)
      end
      puts "==== END #{model.table_name} ===="
    end

    private

    def model
      fail NoMethodError, "Method 'model' must be overridden."
    end

    def data_hash(row)
      column_names.map.with_index do |column_name, i|
        [column_name, row[i]]
      end.to_h
    end

    def column_names
      fail NoMethodError, "Method 'column_names' must be overridden."
    end
  end
end
