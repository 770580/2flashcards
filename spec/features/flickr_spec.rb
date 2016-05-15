require 'rails_helper'

describe 'Flickr', js: true do
  let(:user) { FactoryGirl.create(:user_with_one_block_without_cards) }
  before do
    stub_flickr
    page.driver.headers = { 'Accept-Language' => 'ru' }
    visit root_path
    user_login(user)
    click_link I18n.t('add_card_label')
  end

  it 'should be link Загрузить из Flickr' do
    expect(page).to have_content('Загрузить из Flickr')
  end

  it 'should be link Найти во Flickr' do
    click_link 'Загрузить из Flickr'
    expect(page).to have_content('Найти во Flickr')
  end

  describe 'with word test in search input' do
    before do
      click_link 'Загрузить из Flickr'
      fill_in 'flickr_search_input', with: 'test'
      click_link 'Найти во Flickr'
    end

    it 'should be link with image from flickr' do
      expect(page).to have_css('a.flickr-image-link')
    end

    it 'input Image URL should has correct URL' do
      image = flickr.photos.search(text: 'test', per_page: 10).first
      image_url = FlickRaw.url_n(image)
      find('a.flickr-image-link', match: :first).click
      expect(page).to have_field('Image URL', with: image_url)
    end
  end

  describe 'with empty string in search input' do
    before do
      click_link 'Загрузить из Flickr'
      click_link 'Найти во Flickr'
    end

    it 'should be link with image from flickr' do
      expect(page).to have_css('a.flickr-image-link')
    end

    it 'input Image URL should has correct URL' do
      image = flickr.photos.getRecent(per_page: 10).first
      image_url = FlickRaw.url_n(image)
      find('a.flickr-image-link', match: :first).click
      expect(page).to have_field('Image URL', with: image_url)
    end
  end
end
