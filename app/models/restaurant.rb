class Restaurant < ActiveRecord::Base
  has_many :menus
  has_many :votes

  MENU_PARSERS = %w( kamjest strike )

  def todays_menus
    @todays_menus ||= menus.where('date=? OR regular=true', Date.today).order(:regular)
  end

  def today_votes_number(user)
    @no_of_votes ||= votes.where(date: Date.today, group: user.group).count
  end

  def voters(user)
    @voters ||= votes.where(date: Date.today, group: user.group).map do |vote|
      vote.user
    end
  end

  def update_menus
    return false unless menu_parser.present?
    begin
      instance_eval(menu_parser).each do |day|
        menus.where(date: day[:date]).destroy_all
        menus << day[:menus].map{ |m| Menu.new(m) }
      end
      true
    rescue
      false
    end
  end

  def menu_parser_enum
    MENU_PARSERS
  end

  rails_admin do
    create do
      field :kamjest_id do
        label 'Kam jest ID'
      end
      include_all_fields
      exclude_fields :votes, :menus
    end

    edit do
      field :kamjest_id do
        label 'Kam jest ID'
      end
      include_all_fields
      exclude_fields :votes, :menus
    end
  end

  private

  def kamjest
    KamjestCommunicator.get_menus(kamjest_id)
  end

  def strike
    StrikeParser.get_menus
  end
end
