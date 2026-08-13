class AllowNullEmailForCustomers < ActiveRecord::Migration[7.2]
  def up
    remove_index :customers, :email if index_exists?(:customers, :email)

    change_column_default :customers, :email, from: "", to: nil
    change_column_null :customers, :email, true

    Customer.where(email: "").update_all(email: nil)

    add_index :customers, :email, unique: true
  end

  def down
    remove_index :customers, :email if index_exists?(:customers, :email)

    Customer.where(email: nil).update_all(email: "")

    change_column_null :customers, :email, false
    change_column_default :customers, :email, from: nil, to: ""

    add_index :customers, :email, unique: true
  end
end
