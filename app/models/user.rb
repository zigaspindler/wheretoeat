class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :votes
  has_many :comments
  belongs_to :group

  store_accessor :settings, :collapsed

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def voted?(restaurant_id)
    !votes.where(restaurant_id: restaurant_id, date: Date.today).empty?
  end

  def initials
    "#{username[0]}#{username[-1]}".upcase
  end

  def collapsed?
    collapsed == 'true'
  end
end
