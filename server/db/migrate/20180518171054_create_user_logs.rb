class CreateUserLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :user_logs do |t|
      t.date :target_date, null: false
      t.integer :male_10, null: false, default: 0
      t.integer :male_20, null: false, default: 0
      t.integer :male_30, null: false, default: 0
      t.integer :male_40, null: false, default: 0
      t.integer :male_50, null: false, default: 0
      t.integer :male_60, null: false, default: 0
      t.integer :female_10, null: false, default: 0
      t.integer :female_20, null: false, default: 0
      t.integer :female_30, null: false, default: 0
      t.integer :female_40, null: false, default: 0
      t.integer :female_50, null: false, default: 0
      t.integer :female_60, null: false, default: 0

      t.timestamps

      t.index :target_date, unique: true
    end
  end
end
