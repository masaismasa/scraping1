require 'nokogiri'
require 'anemone'


OPTS = {
  depth_limit: 0,

}


Anemone.crawl("http://myhome.nifty.com/rent/tokyo/adachiku/oyata", OPTS) do |anemone|
  anemone.on_every_page do |page|
    page.doc.xpath('/html//table[@id="searchResultList"]').each do |node|
      agency = node.xpath('.//tr/td[contains(@class,"company")]/span[@class="addTxt"]/text()').to_s
      
      price = node.xpath('.//tr/td[4]/span[1]/text()').to_s
      
      puts agency + "：" + price + "万円"
      
    end
  end
end


PRICELIST_XPATH = '/html//div[@class="priceList"]//tbody[@id="prg-aggregate-graph"]/tr'.freeze
AREA_XPATH = './td[@class="area"]/a/text()'.freeze
MADORI_XPATH = './td[@class="madori"]/text()'.freeze
PRICE_XPATH = './td[contains(@class,"price")]/div[@class="money"]/span/text()'.freeze
 
PLACE_XPATH = '/html/body//h2/span[@class="key"]/text()'.freeze

  anemone.on_pages_like(%r{#{BASE_URL}/city/price}) do |page|
    page.doc.xpath(PRICELIST_XPATH).each do |node|
      area  = node.xpath(AREA_XPATH).to_s
      price = node.xpath(PRICE_XPATH).to_s
      puts area + ',' + price + "万円\n"
    end
  end
  
puts array.join("\n")