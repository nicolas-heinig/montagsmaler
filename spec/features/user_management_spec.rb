require 'rails_helper'

describe 'Usermanagement' do
  context 'Access' do
    it 'can be used by admins' do
      login_as_admin
      visit root_path
      find('a.dropdown-toggle').click

      expect(page).to have_content('Userverwaltung')

      visit users_path
      expect(find('h2')).to have_content('Userverwaltung')
    end

    it 'can not be used by members' do
      login_as(FactoryGirl.create(:user))
      visit root_path
      find('a.dropdown-toggle').click

      expect(page).to have_no_content('Userverwaltung')

      visit users_path
      expect(page).to have_content('Du brauchst Admin Rechte!')
    end
  end

  context 'Features' do
    before(:each) do
      login_as_admin
      visit users_path
    end

    it 'lists users' do
      expect(all('tr').count).to eq(1)
    end

    it 'adds users' do
      find('a.btn.btn-primary.pull-right.hidden-xs').click

      fill_in 'Username', with: 'TEST'
      fill_in 'Email', with: 'example@test.com'
      fill_in 'Passwort', with: 'testtest'
      click_button 'Speichern'

      expect(page).to have_content('User gespeichert')
      expect(all('tr').count).to eq(2)
      expect(all('tr').last.all('td').first).to have_content('TEST')
    end

    it 'deletes users', js: true do
      FactoryGirl.create(:user, username: 'TEST', email: 'example@test.com')

      visit users_path
      all('a[data-method="delete"]').last.click
      accept_alert

      expect(page).to have_content('User gelöscht')
    end

    it 'deletes users in small screen', js: true do
      page.driver.browser.manage.window.resize_to(420, 500)
      user = FactoryGirl.create(:user, username: 'TEST', email: 'example@test.com')

      visit users_path
      all('i.fa-pencil').last.click
      expect(page).to have_selector("\#optionModal#{user.id}", visible: true)

      find('.btn-danger').click
      accept_alert

      expect(page).to have_content('User gelöscht')
    end
  end
end
