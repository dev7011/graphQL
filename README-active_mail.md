
✅ STEP 1: Get Started ♦️
    rails g mailer welcome send_greetings_notification
    
    👉 mailers/welcome_mailer.rb füge hinzu:
        
        class WelcomeMailer < ApplicationMailer
            def send_greetings_notification user
                @user ||= user
                mail to: user.mail_address, subject: "Confirm Your Account" if user.mail_address?
            end
        end

✅ STEP 2: Mailer Configuration ♦️
    ⚠️ MAILHOG (Development) und SMTP (Production)

    ♦️ In config/environments/development.rb füge hinzu: (♦️ MAILHOG)
        
        config.action_mailer.delivery_method = :smtp
        config.action_mailer.smtp_settings = {
            address: "localhost",
            port: 1025
        }

    ♦️ In config/environments/production.rb füge hinzu: (für echten SMTP-Server)
        
        config.action_mailer.delivery_method = :smtp
        config.action_mailer.smtp_settings = {
          address: "smtp.gmail.com",
          port: 587,
          user_name: "your_email@gmail.com",
          password: "your_app_password",
          authentication: "plain",
          enable_starttls_auto: true
        }