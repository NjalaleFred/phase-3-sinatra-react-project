class AddColumnDoctorIdForUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :doctor_id, :integer
    add_column :users, :patient_id, :integer
  end
end
