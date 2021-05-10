class CreateAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|
      t.integer :patient_id
      t.integer :doctor_id
      t.text :reason
      t.string :status
      t.date :time_slot

      t.timestamps
    end
    add_index :appointments, :patient_id
    add_index :appointments, :doctor_id
    add_index :appointments, [:patient_id, :doctor_id,:time_slot], unique: true
  end
end
