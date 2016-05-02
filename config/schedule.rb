every :day, at: '11:00 am' do
  runner 'User.pending_cards_notification'
end
