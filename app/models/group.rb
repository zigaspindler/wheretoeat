class Group < ActiveRecord::Base
  has_many :users
  has_many :comments
  has_many :votes

  accepts_nested_attributes_for :users
end
