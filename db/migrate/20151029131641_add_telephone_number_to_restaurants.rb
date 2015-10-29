class AddTelephoneNumberToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :telephone_number, :string
  end
end
