class AddAuthenticationColumnsToUser < ActiveRecord::Migration
	def change
		add_column :users, :auth_token, :string
		add_column :users, :confirmed, :boolean, default: false
	end
end
