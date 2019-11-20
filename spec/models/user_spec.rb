require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }

  it { is_expected.to validate_presence_of :first_name }
  it { is_expected.to validate_presence_of :last_name }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

  it 'is valid' do
    expect(user).to be_valid
  end

  it 'is invalid wituout name' do
    user.name = ''
    expect(user).to_not be_valid
  end

  it 'is invalid wituout email' do
    user.email = '     '
    expect(user).to_not be_valid
  end

  it 'is invalid with too long name' do
    user.name = 'a' * 51
    expect(user).to_not be_valid
  end

  it 'is invalid with too long email' do
    user.email = 'a' * 244 + '@example.com'
    expect(user).to_not be_valid
  end

  specify 'email validation should accept valid addresses' do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      user.email = valid_address
      assert user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  # test 'email validation should reject invalid addresses' do
  #   invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
  #                          foo@bar_baz.com foo@bar+baz.com]
  #   invalid_addresses.each do |invalid_address|
  #     @user.email = invalid_address
  #     assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
  #   end
  # end

  # test 'email addresses should be unique' do
  #   duplicate_user = @user.dup
  #   @user.save
  #   assert_not duplicate_user.valid?
  # end

  # test 'password should be present (nonblank)' do
  #   @user.password = @user.password_confirmation = ' ' * 6
  #   assert_not @user.valid?
  # end

  # test 'password should have a minimum length' do
  #   @user.password = @user.password_confirmation = 'a' * 5
  #   assert_not @user.valid?
  # end

  # test 'authenticated? should return false for a user with nil digest' do
  #   assert_not @user.authenticated?(:remember, '')
  # end

  # test 'associated microposts should be destroyed' do
  #   @user.save
  #   @user.microposts.create!(content: 'Lorem ipsum')
  #   assert_difference 'Micropost.count', -1 do
  #     @user.destroy
  #   end
  # end

  # test 'should follow and unfollow a user' do
  #   michael = users(:michael)
  #   archer  = users(:archer)
  #   assert_not michael.following?(archer)
  #   michael.follow(archer)
  #   assert michael.following?(archer)
  #   assert archer.followers.include?(michael)
  #   michael.unfollow(archer)
  #   assert_not michael.following?(archer)
  # end

  # test 'feed should have the right posts' do
  #   michael = users(:michael)
  #   archer  = users(:archer)
  #   lana    = users(:lana)
  #   # Posts from followed user
  #   lana.microposts.each do |post_following|
  #     assert michael.feed.include?(post_following)
  #   end
  #   # Posts from self
  #   michael.microposts.each do |post_self|
  #     assert michael.feed.include?(post_self)
  #   end
  #   # Posts from unfollowed user
  #   archer.microposts.each do |post_unfollowed|
  #     assert_not michael.feed.include?(post_unfollowed)
  #   end
  # end
end
