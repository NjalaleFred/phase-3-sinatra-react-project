class AddUniqueIndexesToUsers < ActiveRecord::Migration[6.1]
  def change
    add_index :users, :doctor_id, unique: true
    add_index :users, :patient_id, unique: true
  end
end
