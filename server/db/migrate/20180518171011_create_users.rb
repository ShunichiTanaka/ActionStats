class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.integer :gender, null: false
      t.integer :year_of_birth, null: false
      t.integer :prefecture, null: false
      t.date :registered_at, null: false
      t.date :left_at
      t.string :identifier, null: false

      t.timestamps

      t.index :gender
      t.index :year_of_birth
      t.index :prefecture
      t.index :registered_at
      t.index :left_at
      t.index :identifier, unique: true
    end
  end
end
