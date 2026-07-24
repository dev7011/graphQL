🛑 SIDEKIQ - Hintergrundjobs in Rails
    ♦️redis wird verwendet, um die Warteschlangen zu verwalten.


✅ 1. Gemfile

    gem "sidekiq", ">= 7.4"
    gem "uri", ">= 0.13.1"
    
bundle install

✅ 2. ActiveJob auf Sidekiq umstellen
    nano config/application.rb oder
    nano config/environments/development.rb

        config.active_job.queue_adapter = :sidekiq

==================================================

✅ 3. Create JOB, zum Beispiel Announcement

    rails generate job Announcement
    👉 nano app/jobs/Announcement_job.rb
        class AnnouncementJob < ApplicationJob
          queue_as :default

          def perform(email)
            5.times do |i|
              Rails.logger.info "Sende E-Mail an #{email}... (#{i + 1}/5)"
            end
          end

✅ 4. ROUTE/ REDIS
    Sidekiq Web UI einbauen 👉 status der Jobs überwachen

    👉 nano config/routes.rb füge hinzu:
        
        require 'sidekiq/web'
        Rails.application.routes.draw do
        mount Sidekiq::Web => '/sidekiq'
            # mit login
            # authenticate :user, lambda { |u| u.admin? } do
            #   mount Sidekiq::Web => '/sidekiq'
            # end
       end

    🟣 REDIS: Verbindung von Rails → Redis

✅ 5. sidekiq
    Sidekiq muss wissen, wo Redis läuft.
    👉️ nano config/initializers/sidekiq.rb

          require 'sidekiq'
          redis_url = ENV.fetch("REDIS_URL", "redis://localhost:6379/0")

          Sidekiq.configure_server do |config|
            config.redis = { url: redis_url }
          end

          Sidekiq.configure_client do |config|
            config.redis = { url: redis_url }
          end


🏀 Sidekiq STARTEN 

    rails s
    bundle exec sidekiq
    
    TESTEN: console 
       AnnouncementJob.perform_later("tnle@gmail.com")
       http://localhost:3000/sidekiq

    ✅jods in die Warteschlange, z.B cosole
        AnnouncementJob.perform_later("tnle@gmail.com")

🏀 FEHLERBEHEBUNG

    bundle update sidekiq
    gem "sidekiq", ">= 7.4"
    bundle install

    ♦️uninitialized constant URI::RFC2396_PARSER by sidekiq
        bundle update uri


