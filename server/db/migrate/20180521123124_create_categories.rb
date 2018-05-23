class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.integer :display_order, null: false, default: 0

      t.timestamps

      t.index :name, unique: true
    end
  end
end
