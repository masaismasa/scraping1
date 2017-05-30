require 'nokogiri'
require 'anemone'
require 'capybara/poltergeist'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, {:js_errors => false, :timeout => 1000 })
end

session = Capybara::Session.new(:poltergeist)
session.visit "http://myhome.nifty.com/rent/tokyo/adachiku/oyata/"
puts session.status_code
puts '最寄り駅/徒歩分/広さ/家賃/築年数'

1.upto(40) do |num|
  #
  puts num.to_s
  puts session.find('td.address:first-child').text
end





