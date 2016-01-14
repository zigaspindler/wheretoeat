class KamjestCommunicator
  include HTTParty
  base_uri 'https://kam-jest.herokuapp.com'

  def initialize(restaurant)
    @restaurant = restaurant
  end

  def get_menus
    response = self.class.post('/graphql',
      body: {
        query: "{restaurants(id:\"#{@restaurant.kamjest_id}\"){id dailyOffers{date offers{text type price}}}}"
      }
    )
    response['data']['restaurants'].first['dailyOffers']
  end
end
