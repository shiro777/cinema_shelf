# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }
  let(:admin_user) { FactoryBot.create(:user, :admin) }

  let(:user_params) { FactoryBot.attributes_for(:user) }
  let(:other_user_params) { FactoryBot.attributes_for(:other_user) }
  let(:admin_user_params) { FactoryBot.attributes_for(:user, :admin) }

  describe "#index" do
    context "when as a logged_in user" do
      before do
        log_in user
        get :index
      end

      it "responds http success" do
        expect(response).to have_http_status :success
      end

      it "renders template" do
        expect(response).to render_template "users/index"
      end
    end

    context "when not as a logged_in user" do
      before do
        get :index
      end

      it "redirects to login url" do
        expect(response).to redirect_to login_url
      end
    end
  end

  describe "#new" do
    before do
      get :new
    end

    it "returns http success" do
      expect(response).to have_http_status :success
    end

    it "renders template" do
      expect(response).to render_template "users/new"
    end
  end

  describe "#create" do
    it "redirects successfully" do
      create_with_http user_params
      expect(response).to redirect_to root_url
    end

    it "changes User count" do
      expect { create_with_http user_params }.to change(User, :count).by(1)
    end

    it "is forbidden when admin parameter is true" do
      create_with_http admin_user_params
      expect(assigns(:user).admin).to be false
    end

    it "sends 1 mail" do
      ActionMailer::Base.deliveries.clear
      create_with_http user_params
      expect(ActionMailer::Base.deliveries.size).to eq 1
    end
  end

  describe "#show" do
    it "responds http success" do
      get :show, params: { id: user.id }
      expect(response).to have_http_status :success
    end

    it "renders a template" do
      get :show, params: { id: user.id }
      expect(response).to render_template "users/show"
    end

    it "redirects to root url when user isn't activated" do
      not_activated_user = FactoryBot.create(:user, :not_activated)
      get :show, params: { id: not_activated_user.id }
      expect(response).to redirect_to root_url
    end
  end

  describe "#edit" do
    context "when log in as a correct user" do
      before do
        log_in user
        get :edit, params: { id: user.id }
      end

      it "responds http success" do
        expect(response).to have_http_status :success
      end

      it "renders a template" do
        expect(response).to render_template "users/edit"
      end
    end

    context "when log in as a other user" do
      before do
        log_in other_user
        get :edit, params: { id: user.id }
      end

      it "redirects to root url" do
        expect(response).to redirect_to root_url
      end
    end

    context "when not log in" do
      before do
        get :edit, params: { id: user.id }
      end

      it "redirects to login url" do
        expect(response).to redirect_to login_url
      end
    end
  end

  describe "#update" do
    context "when log in as a correct user" do
      before do
        log_in user
        update_with_http user, other_user_params
      end

      it "redirects successfully" do
        expect(response).to redirect_to user_url(user.id)
      end

      it "changes user name for a variable" do
        expect(assigns(:user).name).to eq other_user_params[:name]
      end

      it "changes user name for active_record" do
        expect(user.reload.name).to eq other_user_params[:name]
      end
    end

    context "when log in as a other user" do
      before do
        log_in other_user
        update_with_http user, other_user_params
      end

      it "redirects to root url" do
        expect(response).to redirect_to root_url
      end

      it "doesn't change user name" do
        expect(user.reload.name).to_not eq other_user_params[:name]
      end
    end

    context "when not log in" do
      before do
        update_with_http user, other_user_params
      end

      it "redirects to login url" do
        expect(response).to redirect_to login_url
      end

      it "doesn't change user name" do
        expect(user.reload.name).to_not eq other_user_params[:name]
      end
    end
  end

  describe "#destroy" do
    context "when as a admin user" do
      before do
        log_in admin_user
      end

      it "redirects to users url" do
        destroy_with_http other_user
        expect(response).to redirect_to users_url
      end

      it "changes User count" do
        other_user = FactoryBot.create(:other_user)
        expect { destroy_with_http other_user }.to change(User, :count).by(-1)
      end
    end

    context "when not as a admin user" do
      before do
        log_in user
      end

      it "redirects to root url" do
        destroy_with_http other_user
        expect(response).to redirect_to root_url
      end

      it "doesn't change User count" do
        other_user = FactoryBot.create(:other_user)
        expect { destroy_with_http other_user }.to change(User, :count).by(0)
      end
    end
  end

  def create_with_http(user_params)
    post :create, params: { user: user_params }
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def update_with_http(user, user_params)
    patch :update, params: { id: user.id, user: user_params }
  end

  def destroy_with_http(user)
    delete :destroy, params: { id: user.id }
  end
end
