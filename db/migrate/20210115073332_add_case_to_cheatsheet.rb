class AddCaseToCheatsheet < ActiveRecord::Migration[6.1]
  def change
    add_reference :cases, :cheatsheet, null: false, foreign_key: true
  end
end
