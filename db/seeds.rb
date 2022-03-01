# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'nokogiri'

url = "https://www.rowticket.com/ar/eventos/category/musica/"

html_file = URI.open(url).read
html_doc = Nokogiri::HTML(html_file)

url_events = []

html_doc.search('.event').each do |element|
  url_events << element.attribute("href").value
end

url_events.each do |event|

  p event
  event_file = URI.open(event).read
  event_doc = Nokogiri::HTML(event_file)

  p event_doc.search('.event-title').text
  p event_doc.search('.place a').attribute("title").value
  p event_doc.search('.tribe-street-address').text
  p event_doc.search('.tribe-locality').text
  p event_doc.search('.tribe-country-name').text
  p event_doc.css('.hero').attribute('style').value[/\(.*?\)/].tr('(','').tr(')','')


  p event_doc.css('.swiper-wrapper')[0].children[-2].attribute("style").value[/\(.*?\)/].tr('(','').tr(')','')

end
