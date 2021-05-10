class AddDefaultToAppointments < ActiveRecord::Migration[6.1]
  def change
    change_column_default :appointments, :status, from: nil, to: "pending"
  end
end
