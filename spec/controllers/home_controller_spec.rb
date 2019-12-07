# frozen_string_literal: true

require "rails_helper"

RSpec.describe HomeController, type: :controller do
  describe "#top" do
    it "responds successfully" do
      get :top
      expect(response).to be_success
    end

    it "returns a 200 response" do
      get :top
      expect(response).to have_http_status "200"
    end

    it "returns http success" do
      get :top
      expect(response).to have_http_status(:success)
    end
  end

  describe "#about" do
    it "responds successfully" do
      get :about
      expect(response).to be_success
    end

    it "returns a 200 response" do
      get :about
      expect(response).to have_http_status "200"
    end

    it "returns http success" do
      get :about
      expect(response).to have_http_status(:success)
    end
  end
end
