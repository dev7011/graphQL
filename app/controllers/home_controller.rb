class HomeController < ApplicationController
  def index
  end

  def sidekiq
    AnnouncementJob.perform_later("tnle@gmail.com")
    redirect_to root_path
  end
end
