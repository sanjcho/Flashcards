FactoryGirl.define do
  factory :user do
    email "someemail@mail.ru"
    password  "somepassword"
    password_confirmation "somepassword"
  end
end
