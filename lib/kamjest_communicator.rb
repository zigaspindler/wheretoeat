class KamjestCommunicator
  include HTTParty
  base_uri 'https://kam-jest.herokuapp.com'

  def self.get_menus(id)
    response = self.post('/graphql',
      body: {
        query: "{restaurants(id:\"#{id}\"){dailyOffers{date offersImages offers{text type price}}}}"
      }
    )
    parse_response id, response
  end

  private

  def self.parse_response(kamjest_id, response)
    res = response['data']['restaurants'].first
    res['dailyOffers'].map do |d|
      {
        date: d['date'],
        images: parse_images(d['offersImages'], d['date']),
        menus: parse_menus(d['offers'], d['date'], kamjest_id).compact
      }
    end
  end

  def self.parse_menus(menus, date, id = nil)
    menus.map do |m|
      unless (m['type'] == 'KOSILO' and id == 'selih')
        {
          date: date,
          description: m['text'],
          price: m['price'],
          regular: false
        }
      end
    end
  end

  def self.parse_images(images, date)
    images.map do |url|
      {
          url: url,
          date: date
      }
    end
  end
end
