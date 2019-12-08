require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "#edit" do
    let(:user) { FactoryBot.create(:user) }

    it "friendly forwards after log in" do
      get edit_user_path(user)
      expect(response).to redirect_to login_url
      log_in user
      expect(response).to redirect_to edit_user_path(user)
    end
  end

  def log_in(user, remember_me: 0)
    post login_path, params: { session: { email: user.email,
                                    password: user.password,
                                    remember_me: remember_me } }
  end
end
