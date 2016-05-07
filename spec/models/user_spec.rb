require 'rails_helper'

describe User do
  it 'sends pending card notify on email' do
    FactoryGirl.create(:user_with_one_block_and_one_card)
    expect { User.pending_cards_notification }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end
end
