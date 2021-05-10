module Mutations
  class UpdateStatusOfAppointment < BaseMutation
    argument :id, ID, required: true
    argument :status, String, required: true
    field :appointment, Types::AppointmentType, null: true
    field :doctor, Types::UserType, null: true
    field :patient, Types::UserType, null: true
    def resolve(id:, status:)
      appointment=Appointment.find(id)
      appointment.update_attribute(:status,status)
      {
      appointment: appointment,
      doctor: appointment.doctor,
      patient: appointment.patient
      }
    end
  end
end
