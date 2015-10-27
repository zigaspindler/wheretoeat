class Restaurant < ActiveRecord::Base
  has_many :menus
  has_many :votes

  def grouped_menus
    menus_array = []
    for date in Date.today..4.days.from_now
      menus_array << {date: date, menus: menus.where(date: date)}
    end
    menus_array
  end

  def todays_menus
    @todays_menus ||= menus.where(date: Date.today)
  end

  def today_votes_number
    @no_of_votes ||= votes.where(date: Date.today).count
  end

  def voters
    @voters ||= votes.where(date: Date.today).map do |vote|
      vote.user
    end
  end

  def helpers
    ActionController::Base.helpers
  end
end
