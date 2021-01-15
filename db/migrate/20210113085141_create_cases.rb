class CreateCases < ActiveRecord::Migration[6.1]
  def change
    create_table :cases do |t|
      t.text :description

      t.timestamps
    end
  end
end
