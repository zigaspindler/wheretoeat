class Group < ActiveRecord::Base
  has_many :users
  has_many :comments
  has_many :votes
  has_many :groups_restaurants
  has_many :restaurants, through: :groups_restaurants

  accepts_nested_attributes_for :users

  def balance_table?
    has_sr? || has_splitwise?
  end

  def has_sr?
    !(sr_id.nil? || sr_id == '')
  end

  def has_splitwise?
    !(splitwise_url.nil? || splitwise_url == '')
  end

  def has_splitwise_group_id?
    !(splitwise_group_id.nil? || splitwise_group_id == '')
  end

  def balance_table_link
    return "https://www.shortreckonings.com/sr##{sr_id}" if has_sr?
    return "https://secure.splitwise.com/#/groups/#{splitwise_group_id}" if has_splitwise_group_id?
    ''
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
      field :splitwise_url
      field :splitwise_group_id
      field :users
    end
  end
end
