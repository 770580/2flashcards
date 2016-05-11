require 'rails_helper'

describe 'Flickr' do
  let(:user) { FactoryGirl.create(:user_with_one_block_without_cards) }

  before do
  	Capybara.current_session.driver.headers = { 'Accept-Language' => 'ru' }
    visit root_path
    user_login(user)
    click_link 'Добавить карточку'
    fill_in 'Оригинал', with: '12'
    fill_in 'Перевод', with: '21'
  end

  it 'should be button Flickr' do
    expect(page).to have_content('Flickr')
  end

  it 'should be modal window after click button Flickr', js: true do
      click_link 'Flickr'
        within '#flickrModalBox' do
          expect(page).to have_content('Выбор изображения с Flickr')
        end
  end
end
