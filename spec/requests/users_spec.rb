# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Users", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:user_params) { FactoryBot.attributes_for(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }
  let(:admin_user) { FactoryBot.create(:user, :admin) }

  describe "#index" do
    describe "activated users" do
      before do
        FactoryBot.create_list(:other_user, 12)
        FactoryBot.create_list(:other_user, 12, :not_activated)
        log_in user
        get users_url
      end

      it "renders activated users" do
        User.where(activated: true).paginate(page: 1, per_page: 25).each do |user|
          expect(response.body).to include user.name
          assert_select "a[href=?]", user_path(user), text: user.name
        end
      end

      it "desn't render not activated users" do
        User.where(activated: false).paginate(page: 1, per_page: 25).each do |user|
          expect(response.body).to_not include user.name
          assert_select "a[href=?]", user_path(user), text: user.name, count: 0
        end
      end
    end

    describe "admin user" do
      before do
        FactoryBot.create_list(:user, 24)
      end

      it "renders user delete links when as a admin user" do
        log_in admin_user
        get users_url
        User.paginate(page: 1, per_page: 25).each do |user|
          assert_select "a[href=?]", user_path(user), text: "削除" unless admin_user == user
        end
      end

      it "does'nt render user delete links when as not a admin user" do
        log_in user
        get users_url
        User.paginate(page: 1, per_page: 25).each do |user|
          assert_select "a[href=?]", user_path(user), text: "削除", count: 0 unless admin_user == user
        end
      end
    end
  end

  describe "#activate" do
    context "when activated with http" do
      before do
        @user = FactoryBot.create(:user, :not_activated)
        activate_with_http @user
      end

      it "signs up with session" do
        expect(session[:user_id]).to_not be_nil
      end

      it "redirects successfully after sign up" do
        expect(response).to redirect_to user_url(@user)
      end
    end

    context "when login with activated account" do
      before do
        @user = FactoryBot.create(:user)
        log_in @user
      end

      it "signs up with session" do
        expect(session[:user_id]).to_not be_nil
      end

      it "redirects successfully after sign up" do
        expect(response).to redirect_to user_url(@user)
      end
    end

    context "when log in with not activated account" do
      before do
        @user = FactoryBot.create(:user, :not_activated)
        log_in @user
      end

      it "signs up with session" do
        expect(session[:user_id]).to be_nil
      end

      it "redirects successfully after sign up" do
        expect(response).to redirect_to root_url
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

  def log_in(user, remember_me: 0)
    post login_path, params: { session: { email: user.email,
                                          password: user.password,
                                          remember_me: remember_me } }
  end

  def activate_with_http(user)
    get edit_account_activation_path(user.activation_token, email: user.email)
  end

  def create_with_http(user_params)
    post users_path, params: { user: user_params }
  end
end
