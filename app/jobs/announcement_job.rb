class AnnouncementJob < ApplicationJob
  queue_as :default

  def perform(email)
    5.times do |i|
      Rails.logger.info "Sende E-Mail an #{email}... (#{i + 1}/5)"

      UserMailer.sidekiq_send_mail(email).deliver_now
    end
  end
end
