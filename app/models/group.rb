class Group < ActiveRecord::Base
  has_many :users
  has_many :comments
  has_many :votes
  has_many :groups_restaurants
  has_many :restaurants, through: :groups_restaurants

  accepts_nested_attributes_for :users

  def balance_table?
    !(sr_id.nil? || sr_id == '')
  end

  rails_admin do
    create do
      field :name
      field :sr_id do
        label 'Shortreckonings ID'
      end
      field :users
    end

    edit do
      field :name
      field :sr_id do
        label 'Shortreckonings ID'
      end
      field :users
    end
  end
end
