module Mutations
  class SignUpUser < BaseMutation
    field :user, Types::UserType, null: true
    field :errors, [String], null: true
    argument :email, String, required: true do
      description "Email field of UserType"
    end
    argument :password, String, required: true do
      description "Password field of UserType"
    end
    argument :name, String, required: true do
      description "Name field of UserType"
    end
    argument :mobile_number, String, required: true do
      description "Mob.Number field of UserType"
    end
    argument :address, String, required: true do
      description "Address field of UserType"
    end
    argument :role, String, required: true do
      description "Role of User"
    end

    def resolve(email:, password:, name:, mobile_number:, address:, role:)
      @user = User.new(email: email, password: password, name: name, mobile_number: mobile_number, address: address)
      @user.add_role role
      if @user.save
        {user: @user,
        errors: []}
      else
        raise GraphQL::ExecutionError, @user.errors.full_messages.join(", ")
        {user: nil,
        errors: @user.errors.full_messages}
      end

    end

  end
end
