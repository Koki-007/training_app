class RenameImageNameColumnToPosts < ActiveRecord::Migration[5.1]
  def change
    rename_column :posts, :image_name, :img
  end
end
