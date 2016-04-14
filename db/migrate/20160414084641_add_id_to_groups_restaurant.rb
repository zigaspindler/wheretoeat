class AddIdToGroupsRestaurant < ActiveRecord::Migration
  def change
    add_column :groups_restaurants, :id, :primary_key
  end
end
