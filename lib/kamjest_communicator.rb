class KamjestCommunicator
  include HTTParty
  base_uri 'https://kam-jest.herokuapp.com'

  def self.get_menus(id)
    response = self.post('/graphql',
      body: {
        query: "{restaurants(id:\"#{id}\"){id dailyOffers{date offers{text type price}}}}"
      }
    )
    parse_response response
  end

  private

  def self.parse_response(response)
    response['data']['restaurants'].first['dailyOffers'].map do |d|
      {
        date: d['date'],
        menus: parse_menus(d['offers'], d['date']).compact
      }
    end
  end

  def self.parse_menus(menus, date)
    menus.map do |m|
      unless m['type'] == 'KOSILO'
        {
          date: date,
          description: m['text'],
          price: m['price'],
          regular: false
        }
      end
    end
  end
end
