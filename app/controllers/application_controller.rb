class ApplicationController < ActionController::API
    SECRET_KEY = Rails.application.secrets.secret_key_base. to_s
    
    def encode(payload, exp = 24.hours.from_now)
        payload[:exp] = exp.to_i
        JWT.encode(payload, SECRET_KEY)
    end
  
    def decode(token)
      decoded = JWT.decode(token, SECRET_KEY)[0]
      HashWithIndifferentAccess.new decoded
    end
    
    def token_generator
        crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
        token = crypt.encrypt_and_sign("user-id:#{ user.id }")
    end

    
    # gets current user from token stored in the session
=begin
    def current_user
        # if we want to change the sign-in strategy, this is the place to do it
        return unless session[:token]

        crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
        token = crypt.decrypt_and_verify session[:token]
        user_id = token.gsub('user-id:', '').to_i
        User.find user_id
    rescue ActiveSupport::MessageVerifier::InvalidSignature
        nil
    end
=end
end
