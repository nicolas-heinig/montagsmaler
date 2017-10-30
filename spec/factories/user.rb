FactoryGirl.define do
  factory :user do
    username 'mistertest'
    email 'test@example.com'
    password '1passwort'
    language 'de'
    role 0

    factory :admin_user do
      role 1
    end
  end
end
