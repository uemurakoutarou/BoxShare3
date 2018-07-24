class CreateForecasts < ActiveRecord::Migration
  def change
    create_table :forecasts do |t|
      t.integer :user_id
      t.integer :fight_id
      t.string :support
      t.text :detail

      t.timestamps null: false
    end
  end
end
