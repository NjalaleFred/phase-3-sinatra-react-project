class CreateDoctors < ActiveRecord::Migration[6.1]
  def change
    create_table :doctors do |table|
      table.string :name
      table.string :specialization
    end
  end
end
