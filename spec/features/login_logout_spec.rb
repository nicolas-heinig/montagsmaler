require 'rails_helper'

describe 'Login and logout process', js: true do
  let(:user) { FactoryGirl.create(:user) }

  before :each do
    visit root_path
    click_link 'Login'
  end

  it 'can log users in' do
    fill_in 'Username or E-Mail', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to have_content('Hallo, Du bist jetzt angemeldet.')
  end

  it 'cant log users without correct password in' do
    fill_in 'Username or E-Mail', with: user.email
    fill_in 'Password', with: 'THIS IS A WRONG PASSWORD'
    click_button 'Log in'

    expect(page).to have_content('Invalid Login or password.')
  end

  it 'can logout users' do
    fill_in 'Username or E-Mail', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    click_link 'test'
    click_link 'Logout'

    expect(page).to have_content('Auf wiedersehen, Du bist jetzt abgemeldet.')
  end
end
