class CreateScenarios < ActiveRecord::Migration[6.1]
  def change
    create_table :scenarios do |t|
      t.string :content
      t.string :example

      t.timestamps
    end
  end
end
