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
  puts "Creating event #{index}"
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
  concert_title = event_doc.css('.event-title').text
  concert_date = event_doc.css('.date').children[0].text

  if concert_date.include?("enero")
    traduction = concert_date.gsub("enero", "january")
  elsif concert_date.include?("febrero")
    traduction = concert_date.gsub("febrero", "february")
  elsif concert_date.include?("marzo")
    traduction = concert_date.gsub("marzo", "march")
  elsif concert_date.include?("abril")
    traduction = concert_date.gsub("abril", "april")
  elsif concert_date.include?("mayo")
    traduction = concert_date.gsub("mayo", "may")
  elsif concert_date.include?("junio")
    traduction = concert_date.gsub("junio", "june")
  elsif concert_date.include?("julio")
    traduction = concert_date.gsub("julio", "july")
  elsif concert_date.include?('agosto')
    traduction = concert_date.gsub('agosto', 'august')
  elsif concert_date.include?("septiembre")
    traduction = concert_date.gsub("septiembre", "september")
  elsif concert_date.include?("octubre")
    traduction = concert_date.gsub("octubre", "october")
  elsif concert_date.include?("noviembre")
    traduction = concert_date.gsub("noviembre", "november")
  elsif concert_date.include?("diciembre")
    traduction = concert_date.gsub("diciembre", "december")
  end

  date = DateTime.parse(traduction)
  formatted_date = date.strftime('%Y/%m/%d %H:%M')

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
  concert = Concert.new(title: concert_title, content: "#{venue_name}, #{venue_address}", date: formatted_date, artist_id: artist.id, venue_id: venue.id)
  concert.photo.attach(io: concert_photo, filename: "concert_photo.jpeg", content_type: "image/jpeg")
  concert.save
end
puts "Finished!"
