class UserMailer < ActionMailer::Base
  default from: "no-reply@ratetools.com"
  def activation_email user
  	@user = user
 		mail(to: user.email, subject: 'Start Rating Programmer Tools Today!')
  end
  def reset_email user
  	@user = user
  	mail(to: user.email, subject: 'Reset Password - Rate Programming Tools')
  end

end
