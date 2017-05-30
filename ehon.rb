# bundler経由でインストールしたgemを有効にするには下記のようにする
require 'bundler'
Bundler.require

# 検索したい絵本のタイトル　URL用に日本語をエンコーディングする必要あり
keyword = "おばけ".encode("Shift_JIS")

# 「K」というパラメーターにkeywordを渡してやれば検索結果の一覧を表示できるみたい
target_url = "http://www.ehonnavi.net/ehon01.asp?sel=1&K=#{keyword}"

# 画像の格納ディレクトリ　なければ作る
dir_path = "./imgs"
FileUtils.mkdir_p(dir_path) unless FileTest.exist?(dir_path)

# スクレイピング用のコード
# クラス名'.detailOneCol'で絞り込んで、eachでまわしながら、
# 1件ずつタイトルを出力　画像は保存
agent = Mechanize.new
search_page = agent.get(target_url)
search_page.search('.detailOneCol').each do |item|
 puts title = item.search('div.text h3').inner_text # さらに絞り込み
 search_page.image_with(alt: "#{title}").fetch.save("#{dir_path}/#{title}.jpg") # altの値がtitleと一致しているので絞り込める
end
