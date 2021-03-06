# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'nokogiri'
require 'date'

url = "https://www.rowticket.com/ar/eventos/category/musica/"

html_file = URI.open(url).read
html_doc = Nokogiri::HTML(html_file)

url_events = []

html_doc.search('.event').each do |element|
  url_events << element.attribute("href").value
end

events = url_events.uniq

puts "Creating db..."
events.each_with_index do |event, index|
  puts "Creating event #{index + 1}"
  event_file = URI.open(event).read
  event_doc = Nokogiri::HTML(event_file)
  concert_title = event_doc.css('.event-title').text
  regex = event_doc.css('.event-title').text[/(\d+)\/(\d+)/]
  artist_name =  regex == nil ?  concert_title.strip : concert_title.tr(regex, '').strip
  url_artist_photo = event_doc.css('.swiper-wrapper')[0].children[-2].attribute("style").value[/\(.*?\)/].tr('(','').tr(')','')
  artist_photo = URI.open(url_artist_photo)
  artist = Artist.new(name: artist_name)
  artist.photo.attach(io: artist_photo, filename: "artist_photo.jpeg", content_type: "image/jpeg")
  artist.save
  venue_name = event_doc.css('.place a').attribute('title').value
  address = event_doc.css('.tribe-street-address').text
  city = event_doc.css('.tribe-locality').text
  country = event_doc.css('.tribe-country-name').text
  venue_address = "#{address}, #{city}, #{country}"
  venue = Venue.new(name: venue_name, address: venue_address)
  venue.save
  concert_date = event_doc.css('.date').children[0].text.downcase

  months_es_array = %w[enero febrero marzo abril mayo junio julio agosto septiembre octubre noviembre diciembre]
  months_en_array = %w[january february march april may june july august september october november december]
  month_en_index = months_es_array.find_index(concert_date.split(' ')[0])
  date_en = concert_date.gsub(concert_date.split(' ')[0], months_en_array[month_en_index])
  date = DateTime.parse(date_en)
  formatted_date = date.strftime('%Y/%m/%d %H:%M')

  concert_title = event_doc.css('.event-title').text
  regex = event_doc.css('.event-title').text[/(\d+)\/(\d+)/]
  artist_name =  regex == nil ?  concert_title.strip : concert_title.tr(regex, '').strip
  venue_name = event_doc.css('.place a').attribute('title').value
  address = event_doc.css('.tribe-street-address').text
  city = event_doc.css('.tribe-locality').text
  country = event_doc.css('.tribe-country-name').text
  venue_address = "#{address}, #{city}, #{country}"
  url_concert_photo = event_doc.css('.hero').attribute('style').value[/\(.*?\)/].tr('(','').tr(')','')
  concert_photo = URI.open(url_concert_photo)
  artist = Artist.find_by_name(artist_name)
  venue = Venue.find_by_name(venue_name)
  concert = Concert.new(title: concert_title, content: "#{venue_name}, #{venue_address}", photo_url: url_concert_photo, date: formatted_date, artist_id: artist.id, venue_id: venue.id, url: event)
  concert.photo.attach(io: concert_photo, filename: "concert_photo.jpeg", content_type: "image/jpeg")
  concert.save
end
puts "Finished!"

puts "Fixing Bad Bunny & Justin Bieber artist pics!"
justin = Artist.find_by_name("Justin Bieber")
justin_photo = URI.open("https://studiosol-a.akamaihd.net/uploadfile/letras/fotos/c/2/c/d/c2cd30c3edca91a3df4e5a69a008cff6.jpg")
justin.photo.attach(io: justin_photo, filename: "justin_photo.jpeg", content_type: "image/jpeg")
justin.save

badbunny = Artist.find_by_name("Bad Bunny")
badbunny_photo = URI.open("https://studiosol-a.akamaihd.net/uploadfile/letras/fotos/4/b/7/5/4b75389fe14b1823e30b0f3de1d3f6d3.jpg")
badbunny.photo.attach(io: badbunny_photo, filename: "badbunny_photo.jpeg", content_type: "image/jpeg")
badbunny.save
puts "Done!"