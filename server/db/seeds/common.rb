module Seeds
  module Common
    def exec
      puts "==== START #{model.table_name} ===="
      CSV.foreach("db/seeds/csvs/#{model.table_name}.csv") do |row|
        next puts "   exist  #{row[0]}" unless model.where(id: row[0]).count == 0
        puts "  create  #{row[0]}: #{row[1]}"
        model.create! data_hash(row)
      end
      puts "==== END #{model.table_name} ===="
    end

    private

    def model
      fail NoMethodError, "Method 'model' must be overridden."
    end

    def data_hash(row)
      (0 .. column_names.length).map do |num|
        next [:id, row[0]] if num == 0
        [column_names[num - 1], row[num]]
      end.to_h
    end

    # 「id」は共通なので省略する
    def column_names
      fail NoMethodError, "Method 'column_names' must be overridden."
    end
  end
end
