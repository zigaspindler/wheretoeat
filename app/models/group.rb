class Group < ActiveRecord::Base
  has_many :users
  has_many :comments
  has_many :votes
  has_many :groups_restaurants
  has_many :restaurants, through: :groups_restaurants

  accepts_nested_attributes_for :users
end
