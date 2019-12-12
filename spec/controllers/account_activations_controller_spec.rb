# frozen_string_literal: true

require "rails_helper"

RSpec.describe AccountActivationsController, type: :controller do
  describe "#edit" do
    before do
      @user = FactoryBot.create(:user, :not_activated)
      activate_with_http @user
    end

    it "activates a user" do
      expect(@user.reload).to be_activated
    end

    it "activate with session" do
      expect(session[:user_id]).to_not be_nil
    end

    it "redirects successfully after activation" do
      expect(response).to redirect_to user_url(@user)
    end
  end

  def activate_with_http(user)
    get :edit, params: { id: user.activation_token, email: user.email }
  end
end
