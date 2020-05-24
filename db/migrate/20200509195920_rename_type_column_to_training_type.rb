class RenameTypeColumnToTrainingType < ActiveRecord::Migration[5.1]
  def change
    rename_column :posts, :type, :training_type
  end
end
