class AddOrderScenariosColumnToCheatsheet < ActiveRecord::Migration[6.1]
  def change
    add_column :cheatsheets, :order_scenarios, :string
  end
end
