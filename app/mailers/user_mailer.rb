class UserMailer < ApplicationMailer

  def sidekiq_send_mail(email)
    mail(
      to: email,
      subject: "Send from Sidekiq"
    )
  end
end
