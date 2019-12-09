require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "#index" do
    before do
      create_other_users
    end

    it "renders pagination" do
      log_in user
      get users_path
      User.paginate(page: 1, per_page:20).each do |user|
        expect(response.body).to include user.name
      end
    end

    context "as a admin user" do
      it "shows user delete links" do
        log_in admin_user
        get users_url
        User.paginate(page: 1, per_page:20).each do |user|
          unless admin_user == user
            assert_select "a[href=?]", user_path(user), text: "削除"
          end
        end
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

  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }
  let(:admin_user) { FactoryBot.create(:user, :admin) }

  def log_in(user, remember_me: 0)
    post login_path, params: { session: { email: user.email,
                                    password: user.password,
                                    remember_me: remember_me } }
  end

  def create_other_users(other_users_count: 19)
    other_users_count.times do |n|
      FactoryBot.create(:other_user)
    end
  end
end
