require "rails_helper"
require "helpers"
require "spec_helper"

RSpec.describe NotificationMailer do
  before do
    @user = create(:user, email: "mymail@mail.ru")
    @deck = create(:deck, user: @user)
  end

  context "NotificationMailer#expired_cards_email" do

    let(:mail) { NotificationMailer.expired_cards_email(@user) }

    it 'renders the subject' do
      expect(mail.subject).to eql(I18n.t("some_expired_flashcards_exists"))
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([@user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['notifications@flashcards-sanjcho.heroku.com'])
    end

    it 'assigns deck.name' do
      expect(mail.html_part.body).to have_content(I18n.t("hellow_our_user"))
    end
  end
end