♦️1. Notification-Komponente pinnen ♦️

     bin/importmap pin @stimulus-components/notification

♦️2. Controller registrieren ♦️
    👉 app/javascript/controllers/index.js füge hinzu:
        
        import { application } from "./application"
        import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
        import Notification from "@stimulus-components/notification"
        eagerLoadControllersFrom("controllers", application)
        application.register("notification", Notification)

♦️3. Configuration in view ♦️
      <div
        data-controller="notification"
        data-notification-delay-value="2000"
        class="transition transform duration-1000 hidden absolute top-[50vh] right-5"
        data-transition-enter-from="opacity-0 translate-x-6"
        data-transition-enter-to="opacity-100 translate-x-0"
        data-transition-leave-from="opacity-100 translate-x-0"
        data-transition-leave-to="opacity-0 translate-x-6"
        role="alert"
      >
         <h1> HIER IST DEIN TEXT<h1>   
      </div>