class RemovePlayerAPointToJudges < ActiveRecord::Migration
  def change
    remove_column :judges, :player_A_point
    remove_column :judges, :player_B_point
  end
end
