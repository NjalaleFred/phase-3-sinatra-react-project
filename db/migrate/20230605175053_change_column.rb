class ChangeColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :medical_records, :diagnsosis, :diagnosis
  end
end
