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

events = url_events.uniq

puts "Creating..."
events.each do |event|
  event_file = URI.open(event).read
  event_doc = Nokogiri::HTML(event_file)
  concert_title = event_doc.css('.event-title').text
  concert_date = event_doc.css('.date').children[0].text
  regex = event_doc.css('.event-title').text[/(\d+)\/(\d+)/]
  artist_name =  regex == nil ?  concert_title.strip : concert_title.tr(regex, '').strip
  venue_name = event_doc.css('.place a').attribute('title').value
  address = event_doc.css('.tribe-street-address').text
  city = event_doc.css('.tribe-locality').text
  country = event_doc.css('.tribe-country-name').text
  venue_address = "#{address}, #{city}, #{country}"
  url_artist_photo = event_doc.css('.swiper-wrapper')[0].children[-2].attribute("style").value[/\(.*?\)/].tr('(','').tr(')','')
  artist_photo = URI.open(url_artist_photo)
  url_concert_photo = event_doc.css('.hero').attribute('style').value[/\(.*?\)/].tr('(','').tr(')','')
  concert_photo = URI.open(url_concert_photo)
  artist = Artist.new(name: artist_name)
  #artist.photo.attach(io: artist_photo, filename: "artist_photo.jpeg", content_type: "image/jpeg")
  artist.save
  venue = Venue.new(name: venue_name, address: venue_address)
  venue_photo.photo.attach(io: concert_photo, filename: "concert_photo.jpeg", content_type: "image/jpeg")

  venue.save

  concert = Concert.new(title: concert_title, content: "#{venue_name}, #{venue_address}", date: concert_date, artist_id: artist.id, venue_id: venue.id)
  concert.save
end
puts "Finished!"
