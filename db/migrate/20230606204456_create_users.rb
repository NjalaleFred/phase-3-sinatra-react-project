class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |table|
      table.string :name
      table.string :email 
      table.string :role
    end
  end
end
