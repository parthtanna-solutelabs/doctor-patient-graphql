module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :users, [Types::UserType], null: false, description: "This is a query that selects all Users in QueryType class"
    field :usersCount, Integer, null: false, description: "This is total num of users count query in QueryType class"
    field :user, Types::UserType, null: true do
      description "Find a user by ID"
      argument :id, ID, required: true
    end
    field :doctors, [Types::UserType], null: true do
    description "Doctors for patients"
    argument :id, ID, required: true
  end
    field :viewAppointments,  [Types::AppointmentType], null: true do
      description "Appointments of current_user"
      argument :id, ID, required: true
    end

    def users
      User.all
    end

    def usersCount
      User.count
    end

    def user(id:)
      User.find(id)
    end

    def doctors(id:)
      user = User.find(id)
      debugger
      if user.has_role? :Doctor
        raise GraphQL::ExecutionError, I18n.t('view_doctors.access_denied')
      else
        Role.find_by_name('Doctor').users
        #User.with_role :Doctor
      end
    end

    def viewAppointments(id:)
      user = User.find(id)  
      if user.has_role? :Patient
        return user.patient_appointments.where('time_slot >= ? AND (status ="confirmed" OR status="pending")',Date.today)
      else
        return user.doctor_appointments.where('time_slot >= ? AND (status ="confirmed" OR status="pending")',Date.today)
      end
    end
  end
end
