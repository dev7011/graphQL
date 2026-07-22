♦️https://www.youtube.com/watch?v=QTbcq2D5gSE&list=PL6SEI86zExmv96zj0-Uz2uwUoNNf0w_dB&index=2
♦️https://github.com/heartcombo/devise

✅ STEP 1: Initialisierung devise ♦️

    bundle add devise
    rails generate devise:install
    config/environments/development.rb füge hinzu:
        config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

    rails g devise:views                ♦️views für devise generieren
    rails generate devise user          ♦️model user generieren
    rails g devise:controllers users    ♦️controller user generieren

    ♦️ routes.rb anpassen
        devise_for :users, controllers: {
            registrations: "users/registrations",
            sessions: "users/sessions",
            passwords: "users/passwords",
            confirmations: "users/confirmations"
        }

✅ STEP : role, username, last_name hinzufügen
    ♦️ app/controllers/users/registrations_controller.rb (was du mit dem Attributes speichern willst)
        
            before_action :configure_sign_up_params, only: [:create]
            protected
                def configure_sign_up_params
                    devise_parameter_sanitizer.permit(
                        :sign_up,
                        keys: %i[
                        username
                        email
                        address
                        last_name
                        password
                        password_confirmation
                        ]
                    )
                end