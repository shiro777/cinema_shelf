# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsersController, type: :controller do
  describe "#index" do
    context "as a logged_in user" do
      before do
        log_in user
        get :index
      end

      it "responds http success" do
        expect(response).to have_http_status :success
      end

      it "renders template" do
        expect(response.body).to render_template "users/index"
      end
    end

    context "not as a logged_in user" do
      before do
        get :index
      end

      it "redirects login url" do
        expect(response).to redirect_to login_url
      end
    end
  end

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

    it "can't sign up with the admin right" do
      admin_params = FactoryBot.attributes_for(:user, :admin)
      create_user admin_params
      expect(assigns(:user).admin).to be false
    end
  end

  describe "#show" do
    before do
      get :show, params: { id: user.id}
    end

    it "responds http success" do
      expect(response).to have_http_status :success
    end

    it "renders a template" do
      expect(response).to render_template "users/show"
    end
  end

  describe "#edit" do
    context "logged in as a correct user" do
      before do
        log_in user
        get :edit, params: {id: user.id}
      end

      it "responds http success" do
        expect(response).to have_http_status :success
      end

      it "renders a template" do
        expect(response).to render_template "users/edit"
      end
    end

    context "logged in as a other user" do
      before do
        log_in other_user
        get :edit, params: {id: user.id}
      end

      it "redirects root url" do
        expect(response).to redirect_to root_url
      end
    end

    context "not logged in" do
      before do
        get :edit, params: {id: user.id}
      end

      it "redirects login url" do
        expect(response).to redirect_to login_url
      end
    end
  end

  describe "#update" do
    context "logged in as a correct user" do
      before do
        log_in user
        update_user user, other_user_params
      end

      it "redirects successfully" do
        expect(response).to redirect_to user_url(user.id)
      end

      it "changes user name" do
        expect(assigns(:user).name).to_not eq user.name
      end

      it "changes user name" do
        expect(user.reload.name).to eq other_user_params[:name]
      end
    end

    context "logged in as a other user" do
      before do
        log_in other_user
        update_user user, other_user_params
      end

      it "redirects root url" do
        expect(response).to redirect_to root_url
      end

      it "doesn't change user name" do
        expect(user.name).to_not eq other_user_params[:name]
      end
    end

    context "not logged in" do
      before do
        update_user user, other_user_params
      end

      it "redirects login url" do
        expect(response).to redirect_to login_url
      end

      it "doesn't change user name" do
        expect(user.name).to_not eq other_user_params[:name]
      end
    end
  end

  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }
  let(:user_params) { FactoryBot.attributes_for(:user) }
  let(:other_user_params) { FactoryBot.attributes_for(:other_user) }

  def create_user(user_params)
    post :create, params: { user: user_params }
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def update_user(user, user_params)
    patch :update, params: { id: user.id, user: user_params }
  end
end
