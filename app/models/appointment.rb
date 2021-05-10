class Appointment < ApplicationRecord
    belongs_to :patient, class_name: "User",optional: true
    belongs_to :doctor, class_name: "User", optional: true
    default_scope -> { order :time_slot }

    validates :patient_id, presence: true,uniqueness: {scope: :time_slot}
    validates :doctor_id, presence: true
    validates :reason, presence: true, length: { in: 6..300 }
    validates :time_slot, presence: true, uniqueness: {scope: :doctor_id}
    resourcify
end
