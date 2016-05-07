require 'rails_helper'

describe 'Card Mailer mail should has' do
  let(:user) { FactoryGirl.create(:user_with_one_block_and_one_card) }
  let(:mail) { CardsMailer.pending_cards_notification(user.email).deliver_now }

  it 'subject' do
    expect(mail.subject).to eq('Наступила даты пересмотра карточек.')
  end

  it 'the receiver email' do
    expect(mail.to).to eq([user.email])
  end

  it 'body' do
    expect(mail.body).to have_content("Перейти на сайт для просмотра карточек")
  end
end
