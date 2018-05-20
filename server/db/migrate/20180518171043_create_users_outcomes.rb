class CreateUsersOutcomes < ActiveRecord::Migration[5.2]
  def change
    create_table :users_outcomes do |t|
      t.date :post_date, null: false
      t.integer :post_time, null: false
      t.integer :user_id, null: false, limit: 8
      t.integer :outcome_id, null: false, limit: 8
      t.integer :reaction, null: false
      t.string :comment

      t.timestamps

      t.index %i[post_date post_time user_id outcome_id], unique: true, name: :index_users_outcomes_on_post_time_and_user_and_outcome
      t.index :reaction
    end
  end
end
