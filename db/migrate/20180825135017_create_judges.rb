class CreateJudges < ActiveRecord::Migration
  def change
    create_table :judges do |t|
      t.integer :user_id
      t.integer :fight_id
      t.integer :round
      t.integer :player_A_point
      t.integer :player_B_point
      t.integer :range

      t.timestamps null: false
    end
  end
end
