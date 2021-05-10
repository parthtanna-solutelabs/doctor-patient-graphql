module Mutations
  class EditUser < BaseMutation
    field :user, Types::UserType, null: true
    field :errors, [String], null: true

    argument :id, ID, required: true
    argument :name, String, required: true 
    argument :mobile_number, String, required: false  
    argument :address, String, required: true  

    def resolve(id:,name:,mobile_number:,address:)
=begin
      if context[:current_user].nil?
        raise GraphQL::ExecutionError, "You need to authenticate first"
      end
=end  
      user=User.find(id)
      
      if user.update(name: name, mobile_number: mobile_number, address: address)
        
        {user: user,
        errors: []}
      else
        raise GraphQL::ExecutionError, user.errors.full_messages.join(",")
      end
      
    end
    
  end
end
