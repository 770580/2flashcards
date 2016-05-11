require 'rails_helper'

describe 'Flickr', js: true do
  let(:user) { FactoryGirl.create(:user_with_one_block_without_cards) }
  let(:image) { flickr.photos.search(tags: 'test').first }
  before do
  	Capybara.current_session.driver.headers = { 'Accept-Language' => 'ru' }
    visit root_path
    user_login(user)
    click_link 'Добавить карточку'
  end

  it 'should be button Flickr' do
    expect(page).to have_content('Flickr')
  end

  it 'should be modal window after click button Flickr' do
    click_link 'Flickr'
      within '#flickrModalBox' do
        expect(page).to have_content('Выбор изображения с Flickr')
      end
  end

  it 'should be link with image from flickr after submit form' do
    click_link 'Flickr'
      within '#flickrModalBox' do
        fill_in 'Что ищем?', with: 'test'
        click_button 'Найти'
        expect(page).to have_css('a.flickr-image-link')
      end
  end

  it 'input Image URL should has correct URL' do
    image_url = FlickRaw.url_n(image)
    click_link 'Flickr'
      within '#flickrModalBox' do
        fill_in 'Что ищем?', with: 'test'
        click_button 'Найти'
        find('a.flickr-image-link', match: :first).click
      end
    expect(page).to have_field('Image URL', with: image_url)
  end
end
