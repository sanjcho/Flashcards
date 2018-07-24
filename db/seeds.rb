# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
require "nokogiri"
require "open-uri"

User.find_or_create_by(email: "testmail@mail.com").update_attributes(password: "somepassword", password_confirmation: "somepassword" )
user = User.first
deck = user.decks.find_or_create_by(name: "My first deck", active: true)
page = Nokogiri::HTML(open("http://www.homeenglish.ru/250Popular1.htm"))
page.css('#middle > table tr').drop(1).each do |item|
  i=1
  2.times do
    orig = item.css('td')[i]&.text&.split(' ')&.first
    i += 1
    transl = item.css('td')[i]&.text
    c = deck.cards.find_or_initialize_by(original_text: orig, translated_text: transl, user: user) if orig && transl
    if c&.valid?
      c.save
    else
      puts c.errors.full_messages if c&.errors&.present?
    end
    i += 2
  end
end
