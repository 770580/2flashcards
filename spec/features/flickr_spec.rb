require 'rails_helper'

describe 'Flickr' do
  let(:user) { FactoryGirl.create(:user_with_one_block_without_cards) }

  before do
    visit root_path
    user_login(user)
    click_link 'Добавить карточку'
    fill_in I18n.t('original_text_label'), with: '12'
    fill_in I18n.t('translated_text_label'), with: '21'
  end

  it 'should be button Flickr' do
    expect(page).to have_content('Flickr')
  end

  
    scenario 'with JavaScript', js: true do
      click_button 'Flickr'
        within '#flickrModalBox' do
          expect(page).to have_content('Выбор изображения с Flickr')
        end
    end
end
