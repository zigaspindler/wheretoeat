class StrikeParser
  include HTTParty
  base_uri 'http://www.centerstrike.si/'

  def self.get_menus
    page = self.get('/index.php/sl/restavracija/malice')
    parse_menus(Nokogiri::HTML(page))
  end

  private

  def self.parse_menus(doc)
    article = doc.search('div[itemprop="articleBody"]').first

    date = Date.strptime(article.search('p').first.text.scan(/\((\d{1,2}\. \d{1,2}\. \d{4})/).flatten.first, "%d. %m. %Y")

    menus_text = article.search('span[style="font-size: 12pt;"]').map(&:text).select{ |t| t.present? }

    price = Restaurant.find_by(name: 'Strike').default_price

    menus = []
    %w( PONEDELJEK TOREK SREDA ČETRTEK PETEK ).each_with_index do |day, i|
      start = menus_text.index(day) + 1
      menu_date = (date + i.days).strftime("%F")
      offers = []
      for j in (1..5)
        offers << {
          date: menu_date,
          description: menus_text[start + j].scan(/\d{1}\..(.+).\(/).flatten.first,
          price: price,
          regular: false
        }
      end

      menus << { date: menu_date, menus: offers }
    end

    menus
  end
end
