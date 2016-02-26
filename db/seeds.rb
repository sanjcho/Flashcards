# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
require "nokogiri"
require "open-uri"

user = User.create(email: "testmail@mail.com", password: "somepassword", password_confirmation: "somepassword" )
deck = user.decks.create(name: "My first deck", active: true)
page = Nokogiri::HTML(open("http://www.homeenglish.ru/250Popular1.htm"))
page.css('#middle > table tr').drop(1).each do |item|
  i=1
  2.times do
    orig = item.css('td')[i].text
    i += 1
    transl = item.css('td')[i].text
    c = deck.cards.new(original_text: orig, translated_text: transl)
    if c.valid?
      c.save
    else
      puts c.errors.full_messages
    end
    i += 2
  end
end
