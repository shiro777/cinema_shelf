require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "#index" do
    before do
      log_in user
      get users_path
    end

    it "renders pagination" do
      User.paginate(page: 1, per_page:20).each do |user|
        expect(response.body).to include user.name
      end
    end
  end

  describe "#edit" do
    it "friendly forwards after log in" do
      get edit_user_path(user)
      expect(response).to redirect_to login_url
      log_in user
      expect(response).to redirect_to edit_user_path(user)
    end
  end

  let(:user) { FactoryBot.create(:user) }

  def log_in(user, remember_me: 0)
    post login_path, params: { session: { email: user.email,
                                    password: user.password,
                                    remember_me: remember_me } }
  end
end
