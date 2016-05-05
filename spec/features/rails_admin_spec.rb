require 'rails_helper'

describe 'Rails Admin' do
  let(:admin_user) { FactoryGirl.create(:admin) }
  let(:normal_user) { FactoryGirl.create(:user, email: "test_normal@test.com") }

  it "if not a login user should be login page" do
    visit rails_admin_path
    expect(page).to have_content("Вход")
  end

  it "if a admin logged should be rails_admin page" do
    user_login(admin_user)
    visit rails_admin_path
    expect(page).to have_content("Управление сайтом")
  end

  it "if a normal user logged should be permission denied" do
    user_login(normal_user)
    visit rails_admin_path
    expect(page).to have_content("Permission denied")
  end
end