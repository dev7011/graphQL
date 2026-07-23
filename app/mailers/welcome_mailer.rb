class WelcomeMailer < ApplicationMailer
  def send_greetings_notification(user)
    @greeting = user.email
    @user ||= user

    mail to: user.email, subject: "Confirm Your Account" if user.email?
  end
end
