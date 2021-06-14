# frozen_string_literal: true

require 'rails_helper'
require 'webdrivers'

# WebDrivers Gem
# https://github.com/titusfortner/webdrivers
#
# Official Guides about System Testing
# https://api.rubyonrails.org/v5.2/classes/ActionDispatch/SystemTestCase.html

RSpec.describe 'Short Urls', type: :system do
  before do
    driven_by :selenium, using: :chrome
    @short_url = FactoryBot.create(:url)
    # If using Firefox
    # driven_by :selenium, using: :firefox
    #
    # If running on a virtual machine or similar that does not have a UI, use
    # a headless driver
    # driven_by :selenium, using: :headless_chrome
    # driven_by :selenium, using: :headless_firefox
  end

  describe 'index' do
    it 'shows a list of short urls' do
      visit root_path
      expect(page).to have_text('HeyURL!')
    end
  end

  describe 'show' do
    it 'shows a panel of stats for a given short url' do
      visit url_path('ABCDE')

      expect(page).to have_text(@short_url.short_url)
      expect(page).to have_text(@short_url.original_url)
    end

    context 'when not found' do
      it 'shows a 404 page' do
        visit url_path('NOTFOUND')
        expect(page).to have_text('Url not found')
      end
    end
  end

  describe 'create' do
    context 'when url is valid' do
      it 'creates the short url' do
        visit '/'
        page.fill_in(:url_original_url, with: 'github.com')
        page.click_button('Shorten URL')

        expect(page).to have_text('http://github.com'.truncate(12))
      end

      it 'redirects to the home page' do
        visit '/'
        page.fill_in(:url_original_url, with: 'github.com')
        page.click_button('Shorten URL')
        expect(page).to have_current_path(urls_path)
      end
    end

    context 'when url is invalid' do
      it 'does not create the short url and shows a message' do
        visit '/'
        page.fill_in(:url_original_url, with: 'github')
        page.click_button('Shorten URL')

        expect(page).to have_text('Invalid Url')
      end

      it 'redirects to the home page' do
        visit '/'
        page.fill_in(:url_original_url, with: 'github')
        page.click_button('Shorten URL')

        expect(page).to have_current_path(urls_path)
      end
    end
  end

  describe 'visit' do
    it 'redirects the user to the original url' do
      visit visit_path('ABCDE')
    end

    context 'when not found' do
      it 'shows a 404 page' do
        visit visit_path('NOTFOUND')

        expect(page).to have_current_path(urls_path)
        expect(page).to have_text('Url not found')
      end
    end
  end
end
