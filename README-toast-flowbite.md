♦️1. Install Flowbite ♦️ 

    npm install
    bundle add jsbundling-rails
    bin/rails javascript:install:esbuild   
    npm install flowbite 

♦️2. app/assets/tailwind/application.css

    @import "tailwindcss";
    @import "flowbite/src/themes/default"; 
    @plugin "flowbite/plugin";
    @source "../../../node_modules/flowbite";

♦️3. Flowbite-JavaScript bereitstellen
    
    mkdir -p vendor/javascript
    cp node_modules/flowbite/dist/flowbite.min.js vendor/javascript/flowbite.js

♦️4. config/importmap.rb füge hinzu:
    
    pin "flowbite", to: "flowbite.js"

♦️5. app/javascript/application.js füge hinzu:

    import "flowbite"

♦️6. Tailwind neu bauen und Anwendung starten
    
    bin/rails tailwindcss:build
    bin/dev


🏀 bei clone muss npm installieren
    
    bundle install
    npm install
    bin/dev
    