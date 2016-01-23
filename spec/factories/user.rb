FactoryGirl.define do
  factory :card do
    original_text "Mom"
    translated_text  "Мама"
  end
#  after(:create) do |card|
#    card.cards.update_attributes(review_date: Date.today.days_ago(4))
#  end
end