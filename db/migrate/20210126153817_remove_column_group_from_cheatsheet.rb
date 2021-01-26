class RemoveColumnGroupFromCheatsheet < ActiveRecord::Migration[6.1]
  def change
    remove_column :cheatsheets, :group_id
  end
end
