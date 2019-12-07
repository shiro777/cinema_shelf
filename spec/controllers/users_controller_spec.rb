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
    it "signs up with session" do
      create_user user_params
      expect(session[:user_id]).to_not be_nil
    end

    it "redirects successfully after sign up" do
      create_user user_params
      expect(response).to redirect_to user_url(session[:user_id])
    end

    it "changes Users count after sign up" do
      expect { create_user user_params }.to change(User, :count).by(1)
    end
  end

    describe "#show" do
      before do
        user = FactoryBot.create(:user)
        get :show, params: { id: user.id}
      end

      it "responds http success" do
        expect(response).to have_http_status :success
      end

      it "responds http success" do
        expect(response).to render_template user_path(user)
      end
    end

  describe "#edit" do
    before do
      user = FactoryBot.create(:user)
      get :edit, params: { id: user.id }
    end

    it "returns http success" do
      expect(response).to have_http_status :success
    end

    it "renders template" do
      expect(response).to render_template(:edit)
    end
  end

  describe "#update" do
    before do
      update_user(user_params)
    end

    it "redirects successfully after edit" do
      expect(response).to redirect_to user_url(user.id)
    end
  end

  let(:user_params) { FactoryBot.attributes_for(:user) }
  # let(:user) { FactoryBot.create(:user) }

  def create_user(user_params)
    post :create, params: { user: user_params }
  end

  def update_user(user_params)
    patch :update, params: { id: user.id, user: user_params }
  end
end
