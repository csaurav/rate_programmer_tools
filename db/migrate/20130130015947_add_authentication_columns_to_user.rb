class AddAuthenticationColumnsToUser < ActiveRecord::Migration
	def change
		add_column :users, :activation_token, :string
		add_column :users, :confirmed, :boolean, default: false
	end
end
