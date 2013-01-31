class ActivationMailer < ActionMailer::Base
  default from: "no-reply@ratetools.com"
  def activation_email(user)
  	@user = user
 		mail(to: user.email, subject: 'Start Rating Programmer Tools Today!')
  end
end
