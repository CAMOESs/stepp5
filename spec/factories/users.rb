FactoryBot.define do
  factory :user do
    name { "MyString" }
    email { "MyString@gmail.com" }
    password_digest { "MyString" }
    admin { false }
  end
  factory :second_user, class: User do
    name { "MyString" }
    email { "MyStrin@gmail.com" }
    password_digest { "123456" }
    password_confirmation { "123456" }
    admin { false }
  end
end
