class AddKamjestIdToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :kamjest_id, :string, default: nil
  end
end
