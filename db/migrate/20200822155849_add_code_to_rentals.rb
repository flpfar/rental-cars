class AddCodeToRentals < ActiveRecord::Migration[6.0]
  def change
    add_column :rentals, :code, :string
    add_index :rentals, :code, unique: true
  end
end
