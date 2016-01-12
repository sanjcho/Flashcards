# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require "nokogiri"
require "open-uri"

page = Nokogiri::HTML(open("http://www.homeenglish.ru/250Popular1.htm"))
a = 14
100.times do
  orig = page.css("td")[a].text
  transl = page.css("td")[a + 1].text
  a += 	3
  Card.create(original_text: orig, translated_text: transl)
end
