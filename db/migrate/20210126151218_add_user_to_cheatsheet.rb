class AddUserToCheatsheet < ActiveRecord::Migration[6.1]
  def change
    add_reference :cheatsheets, :user, foreign_key: true, null: true, default: nil
  end
end
