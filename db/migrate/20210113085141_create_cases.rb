class CreateCases < ActiveRecord::Migration[6.1]
  def change
    create_table :cases do |t|

      t.timestamps
    end
  end
end
