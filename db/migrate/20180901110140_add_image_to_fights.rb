class AddImageToFights < ActiveRecord::Migration
  def change
    add_column :fights, :image, :text
  end
end
