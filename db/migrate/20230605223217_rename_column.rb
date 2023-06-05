class RenameColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :medical_records, :doctors_id, :doctor_id
    rename_column :medical_records, :patients_id, :patient_id
  end
end
