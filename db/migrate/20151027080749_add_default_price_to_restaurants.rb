class AddDefaultPriceToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :default_price, :float
  end
end
