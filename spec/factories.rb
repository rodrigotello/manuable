FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "foo#{n}@example.com" }
    sequence(:name) { |n| "John Doe#{n}" }
    sequence(:nickname) { |n| name.underscore }
    password '12345678'
    sequence(:occupation) { |n| "#{nickname} occupation" }
    sequence(:birthday) { |n| Date.today - 20.years - n.days }
    sequence(:avatar) { |n| Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', "IMG_1.png")) }
    sequence(:about) { |n| "#{name} is Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
                        tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
                        quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
                        consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
                        cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
                        proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
                      }

    password_confirmation { password }

    factory 'cesar' do
      name 'Cesar Cejudo'
      email 'cesar@letwrong.com'
      nickname 'goreorto'
    end

    factory 'claudio' do
      name 'Claudio Tello '
      email 'claudio@manuable.com'
      nickname 'ctello'
    end

    factory :user_with_products do
      # posts_count is declared as an ignored attribute and available in
      # attributes on the factory, as well as the callback via the evaluator
      ignore do
        products_count 5
      end

      # the after(:create) yields two values; the user instance itself and the
      # evaluator, which stores all values from the factory, including ignored
      # attributes; `create_list`'s second argument is the number of records
      # to create and we make sure the user is associated properly to the post
      after(:create) do |user, evaluator|
        FactoryGirl.create_list(:product, evaluator.products_count, user: user)
      end
    end
  end

  factory :product do
    user
    sequence(:name) { |n| "Producto #{n}" }
    price 9.99

    sequence(:about) { |n| "Producto #{n} Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
                            tempor incididunt ut labore et dolore magna aliqua." }
    prop_list { ['hechoamano', 'mexicano', 'madera', 'decoracion', 'cocina', 'dibujo', 'poster', 'joyas', 'joyeria'].random_take 4 }

    ignore do
      attachments_count 1
    end

    after(:create) do |product, evaluator|
      FactoryGirl.create_list(:attachment, evaluator.attachments_count, attachable: product)
    end
  end

  factory :attachment do
    association :attachable
    sequence(:attachment) { |n| Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', "IMG_1.png")) }
  end
end
