class CreateFights < ActiveRecord::Migration
  def change
    create_table :fights do |t|
      t.string :name
      t.date :date
      t.string :place
      t.string :player_A
      t.string :player_B
      t.text :detail
      t.integer :user_id
      t.integer :all_round

      t.timestamps null: false
    end
  end
end
