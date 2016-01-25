FactoryGirl.define do
  factory :user do
    email "someemail@mail.ru"
    password  "password"
    password_confirmation "password"
  end
end
