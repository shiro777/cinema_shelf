require 'rails_helper'

RSpec.feature 'LogIn', type: :feature do
  let(:user) { FactoryBot.create(:user) }

  scenario 'logs in / out and redirects successfully' do
    visit root_path
    click_link 'ログイン'
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button 'ログイン'
    expect(page).to have_current_path user_path(user)
    expect(page).to_not have_css 'header nav a', text: 'ログイン'
    expect(page).to have_css 'header nav a', text: 'ログアウト'
    click_link 'ログアウト'
    expect(page).to have_current_path root_path
    expect(page).to have_css 'header nav a', text: 'ログイン'
    expect(page).to_not have_css 'header nav a', text: 'ログアウト'
  end
end
