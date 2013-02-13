class ChangeAuthTokenColumnToActivationToken < ActiveRecord::Migration
	def change
		rename_column :users, :auth_token, :activation_token
	end
end
