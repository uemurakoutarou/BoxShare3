class RemoveNameToFights < ActiveRecord::Migration
  def change
    remove_column :fights, :name
  end
end
