require 'rails_helper'

describe 'Static Pages' do
  context 'Access' do
    it 'can be used by admins' do
      login_as_admin
      visit root_path
      open_dropdown

      expect(page).to have_content('Static Pages')

      visit(static_pages_path)
      expect(find('h1')).to have_content('Static Pages')
    end

    it 'can not be used by members' do
      login_as(FactoryGirl.create(:user))
      visit root_path
      open_dropdown

      expect(page).to have_no_content('Static Pages')

      visit static_pages_path
      expect(page).to have_content('Du brauchst Admin Rechte!')
    end
  end

  context 'Features' do
    it 'creates static pages' do
      login_as_admin
      visit static_pages_path

      click_new_page_link

      fill_in 'Slug', with: 'test_page'
      fill_in 'Inhalt', with: 'This is some test content'

      click_button 'Speichern'

      expect(all('tr').count).to eq(2)
      expect(all('tr').last.all('td').first).to have_content('test_page')
    end

    it 'provides live preview', js: true do
      login_as_admin
      visit static_pages_path

      click_new_page_link

      fill_in 'Inhalt', with: 'We have a live Preview'

      expect(find('#preview').all('p').first).to have_content('We have a live Preview')
    end

    it 'deletes static pages' do
      login_as_admin
      visit static_pages_path

      all('a[data-method="delete"]').last.click

      expect(all('tr').count).to eq(0)
    end

    it 'parses html' do
      static_page = FactoryGirl.create(:static_page, markup_type: :html)

      visit(static_page.slug)

      expect(find('h1')).to have_content('Test Content')
    end

    it 'parses markdown' do
      static_page = FactoryGirl.create(:static_page, markup_type: :markdown)

      visit(static_page.slug)

      expect(find('h1')).to have_content('Test Content')
    end
  end
end

def click_new_page_link
  find('a.hidden-xs').click
end

def open_dropdown
  find('a.dropdown-toggle').click
end
