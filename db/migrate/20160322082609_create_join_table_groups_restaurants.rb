class CreateJoinTableGroupsRestaurants < ActiveRecord::Migration
  def change
    create_join_table :groups, :restaurants do |t|
      t.index [:group_id, :restaurant_id]
      t.index [:restaurant_id, :group_id]
    end
  end
end
