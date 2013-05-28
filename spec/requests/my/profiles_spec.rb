require 'spec_helper'

describe 'user profile' do
  it 'updates users' do
    sign_in_as_a_user
    visit edit_my_profile_path(f: 's')

    page.find("select#user_state_id")
    page.find("input[type=text]#city-autocomplete")
    page.find("input[type=hidden]#user_city_id")

    within("#edit_user_#{@current_user.id}") do
      fill_in "user_occupation", with: 'Developer'
      fill_in "user_about", with: 'I work at Veramiko'
      fill_in "user_address", with: 'Tulipanes 3407'
      fill_in "user_zipcode", with: '64770'
      fill_in "user_nickname", with: 'goreorto'
      fill_in "user_birthday", with: '1986-04-26'
      find('input[type=submit]').click
    end

    @current_user.reload

    assert_equal @current_user.occupation, 'Developer'
    assert_equal @current_user.about, 'I work at Veramiko'
    assert_equal @current_user.address, 'Tulipanes 3407'
    assert_equal @current_user.zipcode, 64770
    assert_equal @current_user.nickname, 'goreorto'
    assert_equal @current_user.birthday.to_s, '1986-04-26'

  end

end
