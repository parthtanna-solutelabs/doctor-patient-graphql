module Types
  class MutationType < Types::BaseObject
    field :update_status_of_appointment, mutation: Mutations::UpdateStatusOfAppointment
    field :create_appointment, mutation: Mutations::CreateAppointment
    field :edit_user, mutation: Mutations::EditUser
    field :sign_in_user, mutation: Mutations::SignInUser
    field :sign_up_user, mutation: Mutations::SignUpUser
    # TODO: remove me
    
  end
end
