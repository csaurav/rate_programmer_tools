class ActivationMailer < ActionMailer::Base
  default from: "no-reply@ratetools.com"
  def activation_email(user)
 		mail(to: user.email, subject: 'Welcome to Rate Programmer Tools!')
  end
end
