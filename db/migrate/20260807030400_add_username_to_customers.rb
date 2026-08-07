class AddUsernameToCustomers < ActiveRecord::Migration[7.2]
  def change
    add_column :customers, :username, :string, null: false
    add_index :customers, :username, unique: true
  end
end
