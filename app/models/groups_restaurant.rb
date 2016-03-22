class GroupsRestaurant < ActiveRecord::Base
  belongs_to :group
  belongs_to :restaurant
end
