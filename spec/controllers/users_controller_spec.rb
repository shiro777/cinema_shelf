# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsersController, type: :controller do
  describe "#new" do
    before do
      get :new
    end

    it "returns http success" do
      get :new
      expect(response).to have_http_status :success
    end

    it "renders template" do
      expect(response).to render_template "users/new"
    end
  end

  describe "#create" do
    let(:user_params) { FactoryBot.attributes_for(:user) }

    it "sign up and redirects successfully" do
      post :create, params: { user: user_params }
      expect(logged_in?).to be true
      expect(response).to redirect_to user_url(current_user)
    end

    it "change Users.count" do
      expect {
        post :create, params: { user: user_params }
      }.to change(User, :count).by(1)
    end
  end
end
