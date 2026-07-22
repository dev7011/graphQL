♦️1.  FONT-AWESOME-SASS INTEGRIEREN IN RAILS 7♦️

    gem "font-awesome-sass", "~> 6.5.1"
    bundle install

    👉  Datei app/assets/stylesheets/application.css in  app/assets/stylesheets/application.css.scss umbenennen 
        👉 und folgende Zeile hinzufügen:
            *= require_tree .
            *= require_self
            */
            @import "font-awesome";


♦️ README-tailwindcss ♦️
♦️ README-toast-flowbite ♦️
♦️ README-stimulus ♦️

🏀  Bei CLONE oder FEHLERN beim Starten von Rails, kann es sein, dass die Tailwind CSS Datei nicht korrekt gebaut wurde.
    
    npm install
    bin/dev