module UserHelper
	def avatar_url user
		options = 's?=200' + "&d=#{CGI.escape(root_url+'images/no-avatar.jpg')}" 
		"http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}"+options
	end
	def roles
		User::ROLES
	end
end