class CreateCheatsheets < ActiveRecord::Migration[6.1]
  def change
    create_table :cheatsheets do |t|
      t.string :name 

      t.timestamps
    end
  end
end
