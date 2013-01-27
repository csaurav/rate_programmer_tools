class CreateUserTable < ActiveRecord::Migration
  def up
  	create_table :users do |user|
  		user.string :name
  		user.string :password_digest
  		user.timestamps
  	end
  end

  def down
  	drop_table :users
  end
end
