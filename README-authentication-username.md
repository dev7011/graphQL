♦️ https://www.youtube.com/watch?v=f6NPdVJKbaY&list=PL6SEI86zExmv96zj0-Uz2uwUoNNf0w_dB
♦️ https://github.com/heartcombo/devise


✅ STEP: Login mit username implementieren
    
    👉 rails g migration AddUsernameContactAddressLastnameToUsers username:string:uniq address:string last_name:string   
    👉 rails db:migrate

    ♦️ nano app/controllers/users/registrations_controller.rb

        before_action :configure_sign_up_params, only: [:create]
        protected
        def configure_sign_up_params
            devise_parameter_sanitizer.permit(
              :sign_up,
              keys: %i[
                username
                email
                address
                lastname
                password
                password_confirmation
              ]
            )
          end
    ♦️ nano app/views/devise/registrations/new.html.erb


✅ STEP: Devise setup
    config.authentication_keys = [:username_or_email]

✅ STEP: Model User 
    nano app/models/user.rb

    attr_accessor :username_or_email

    def username_or_email
        @username_or_email || self.username || self.email
    end
    
    class << self
    def find_for_authentication(warden_conditions)
    conditions = warden_conditions.dup
    username_or_email = conditions.delete(:username_or_email)
    
          scope = self.all
          scope = scope.where(conditions.to_h)
    
          if username_or_email
            value = username_or_email.to_s.downcase
            scope = scope.where("LOWER(username) = ? OR LOWER(email) = ?", value, value)
          end
    
          scope.first
        end
    end
        

✅ STEP: VIEW
    nano app/views/devise/sessions/new.html.erb

    %div= f.text_field :username_or_email, autofocus: true, autocomplete: "username_or_email"
