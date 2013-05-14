FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "foo#{n}@example.com" }
    sequence(:name) { |n| "John Doe#{n}" }
    sequence(:nickname) { |n| "johndoe#{n}" }
    sequence(:password) { |n| "passwor#{n}" }
    sequence(:avatar) { |n| "IMG_#{n}.jpg"}
    sequence(:about) { |n| "John Doe#{n} is Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
                        tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
                        quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
                        consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
                        cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
                        proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
                      }

    password_confirmation { password }

  end
end
