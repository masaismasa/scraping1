require 'nokogiri'
require 'anemone'



OPTS = {
  depth_limit: 0,

}


Anemone.crawl("http://myhome.nifty.com/rent/tokyo/adachiku/oyata", OPTS) do |anemone|
  anemone.on_every_page do |page|
    page.doc.xpath('/html//table[@id="searchResultList"]').each do |node|
      station = node.xpath('.//tr/td[contains(@class,"address")]/text()[1]').map{|o|o.to_s.strip}
      minutes_walk = node.xpath('//tr/td[3]/text()[1]')
      menseki = node.xpath('.//tr/td[6]/text()[contains(string(), "m")]').map{|o|o.to_s.strip}
      madori1 = node.xpath('//tr/td[6]/text()[1]')
#madoriはない場合も      madori2 = node.path('//tr/td[6]/text()[2]')  
      price = node.xpath('.//tr/td[4]/span[1]/text()')
      sikikin = node.xpath('//tr/td[contains(@class,"deposit")]/text()[1]')
      reikin = node.xpath('//tr/td[contains(@class,"deposit")]/text()[2]')
      age = node.xpath('//tr/td[7]/text()[2]')        
      floor = node.xpath('//tr/td[7]/text()[1]')  
      agency = node.xpath('.//tr/td[contains(@class,"company")]/span[@class="addTxt"]/text()')
      address = node.xpath('//tr/td[2]/a')
      #kanri = ?      
      c = 2
  
      (0..(c - 1)).each do |i|
      puts "----#{i}"
      puts station[i].to_s + "：" + minutes_walk[i].to_s + "分：" + menseki[i].to_s + "：" + price[i].to_s + "万円 :" + age[i].to_s + "："
      
      
      end

    end
  end
end

