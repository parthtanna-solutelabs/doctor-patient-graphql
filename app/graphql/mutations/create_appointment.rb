module Mutations
  class CreateAppointment < BaseMutation
    argument :id, ID, required: true
    argument :doctor_id, Integer, required: true
    argument :reason, String, required: true
    argument :time_slot, GraphQL::Types::ISO8601Date, required: true, validates: {numericality: {greater_than_or_equal_to: Date.today}}
    field :appointment, Types::AppointmentType, null: true
    field :message, String, null: true
    
    def resolve(id:,doctor_id:,reason:,time_slot:)
      user = User.find(id)
      appointment=user.patient_appointments.build(doctor_id: doctor_id, reason:reason, time_slot: time_slot)
      if appointment.save!
        {
          appointment: appointment,
          message: I18n.t('appointment.create.success')
        }
      else
        {
          message: I18n.t('appointment.create.danger')
        }
      end
      
    end
  end
end
