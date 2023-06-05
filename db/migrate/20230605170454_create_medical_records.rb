class CreateMedicalRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :medical_records do |t|
      t.string :diagnsosis
      t.string :treatment
      t.string :medication
      t.string :vitals
      t.integer :doctors_id
      t.integer :patients_id
      t.timestamps
    end
  end
end
