class CreatePatients < ActiveRecord::Migration[6.1]
  def change
    create_table :patients do |table|
      table.string :name
      table.integer :age
      table.string :gender
      table.integer :phone_number
      table.string :email
      table.timestamps
    end
  end
end
