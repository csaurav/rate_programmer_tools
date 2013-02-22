class AddProfileInfoColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bio, :string
    add_column :users, :occupation, :string
    add_column :users, :location, :string
  end
end
