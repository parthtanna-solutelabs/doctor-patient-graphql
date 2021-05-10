module Types
  class AppointmentType < Types::BaseObject
    field :id, ID, null: false
    field :patient_id, Integer, null: true
    field :doctor_id, Integer, null: true
    field :reason, String, null: true
    field :status, String, null: true
    field :time_slot, GraphQL::Types::ISO8601Date, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :user, Types::UserType, null: true
  end
end
