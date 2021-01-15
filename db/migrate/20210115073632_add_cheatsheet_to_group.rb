class AddCheatsheetToGroup < ActiveRecord::Migration[6.1]
  def change
    add_reference :cheatsheets, :group, null: false, foreign_key: true
  end
end
