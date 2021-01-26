class AddColumnCreatorToGroup < ActiveRecord::Migration[6.1]
  def change
    change_table :groups do |t|
      t.references :creator, polymorphic: true 
    end
  end
end
