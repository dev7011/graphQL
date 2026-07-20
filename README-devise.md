♦️1. Initialisierung devise ♦️

    bundle add devise
    rails generate devise:install
    config/environments/development.rb füge hinzu:
        config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

    rails g devise:views                ♦️views für devise generieren
    rails generate devise user          ♦️model user generieren
    rails g devise:controllers users    ♦️controller user generieren


♦️2. Konfigurieren ♦️