# frozen_string_literal: true

require "rails_helper"

RSpec.describe SessionsController, type: :controller do
  describe "#new" do
    before do
      get :new
    end

    it "returns http success" do
      expect(response).to have_http_status :success
    end

    it "renders template" do
      expect(response).to render_template "sessions/new"
    end
  end

  describe "#create, #destroy" do
    let(:user) { FactoryBot.create(:user) }

    context "with remembering" do
      before do
        log_in_with_remembering user
      end

      it "logs in with session" do
        expect(session[:user_id]).to eq user.id
      end

      it "is remembering after log in" do
        expect(cookies.signed[:remember_token]).to_not be_empty
      end

      it "redirects successfully after log in" do
        expect(response).to redirect_to user_url(user)
      end

      context "after log out" do
        before do
          log_out
        end

        it "redirects successfully after log in" do
          expect(response).to redirect_to root_url
        end

        it "logs out without session" do
          expect(session[:user_id]).to be_nil
        end

        it "is remembering after log out" do
          expect(cookies.signed[:remember_token]).to_not be_empty
        end
      end
    end

    context "without remembering" do
      before do
        log_in_without_remembering user
      end

      it "logs in with session" do
        expect(session[:user_id]).to eq user.id
      end

      it "is not remembering after log in" do
        expect(cookies.signed[:remember_token]).to be_nil
      end

      it "redirects successfully after log in" do
        expect(response).to redirect_to user_url(user)
      end

      context "after log out" do
        before do
          log_out
        end

        it "redirects successfully after log in" do
          expect(response).to redirect_to root_url
        end

        it "logs out without session" do
          expect(session[:user_id]).to be_nil
        end

        it "is not remembering after log out" do
          expect(cookies.signed[:remember_token]).to be_nil
        end
      end
    end
  end

  def log_in_with_remembering(user)
    post :create, params: { session: { email: user.email,
                                    password: user.password,
                                    remember_me: 1 } }
  end

  def log_in_without_remembering(user)
    post :create, params: { session: { email: user.email,
                                    password: user.password,
                                    remember_me: 0 } }
  end

  def log_out
    delete :destroy
  end
end
