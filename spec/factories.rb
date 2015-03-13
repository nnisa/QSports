FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :genre do
    sequence(:name)  { |n| "Genre #{n}" }
  end
  
  factory :band do
    sequence(:name)  { |n| "BandName #{n}" }
    description "Cool Band"
  end
end