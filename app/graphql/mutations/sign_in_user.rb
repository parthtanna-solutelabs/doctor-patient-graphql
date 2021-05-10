module Mutations
  class SignInUser < BaseMutation
    null true
    field :user, Types::UserType, null: true
    field :token, String, null: true
    argument :email, String, required: true do
      description "Email field of SignIn Mutation"
    end
    argument :password, String, required: true do
      description "Password field of SignIn Mutation"
    end

    def resolve(email:, password:)
      user = User.find_by(email: email) 
      return unless user 
      return unless user.valid_password?(password)
      crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
      token = crypt.encrypt_and_sign("user-id:#{ user.id }")
      context[:current_user]=user
      #context[:session][:token] = token 
      {
        user: user,
        token: token
      }
    end
  end
end
