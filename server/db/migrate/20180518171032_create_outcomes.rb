class CreateOutcomes < ActiveRecord::Migration[5.2]
  def change
    create_table :outcomes do |t|
      t.integer :category_id, null: false
      t.string :name, null: false
      t.boolean :published, null: false, default: false

      t.timestamps

      t.index :category_id
      t.index :name, unique: true
    end
  end
end
