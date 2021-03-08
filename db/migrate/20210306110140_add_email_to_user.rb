class AddEmailToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :email, :string, unique: true, null: false
  end
end
