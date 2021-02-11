class CreateJoinTableGroupCheatsheet < ActiveRecord::Migration[6.1]
  def change
    create_join_table :groups, :cheatsheets do |t|
      t.index [:cheatsheet_id, :group_id]
      t.index [:group_id, :cheatsheet_id]
    end
  end
end
