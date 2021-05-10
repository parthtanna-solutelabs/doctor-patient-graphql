class AddDetailsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string
    add_column :users, :mobile_number, :string
    add_column :users, :address, :text
  end
end
