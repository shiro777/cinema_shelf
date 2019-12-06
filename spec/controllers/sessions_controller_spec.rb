require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe '#new' do
    before do
      get :new
    end

    it 'returns http success' do
      expect(response).to have_http_status :success
    end

    it 'renders template' do
      expect(response).to render_template 'sessions/new'
    end
  end

  describe '#create, #destroy' do
    let(:user) { FactoryBot.create(:user) }

    it 'logs in / out and redirects successfully' do
      post :create, params: { session: { email: user.email,
                                         password: user.password } }
      expect(logged_in?).to be true
      expect(response).to redirect_to user_url(user)
      delete :destroy
      expect(logged_in?).to be false
      expect(response).to redirect_to root_url
    end
  end
end
