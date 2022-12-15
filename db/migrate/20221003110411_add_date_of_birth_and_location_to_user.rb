class AddDateOfBirthAndLocationToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :date_of_birth, :date
    add_column :users, :location, :integer, default: 0, null: false
  end
end
