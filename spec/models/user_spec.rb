# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }
  let(:duplicate_user) { user.dup }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :email }
  # it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

  it "is valid" do
    expect(user).to be_valid
  end

  it "is invalid wituout name" do
    user.name = ""
    expect(user).to_not be_valid
  end

  it "is invalid wituout email" do
    user.email = "     "
    expect(user).to_not be_valid
  end

  it "is invalid with too long name" do
    user.name = "a" * 51
    expect(user).to_not be_valid
  end

  it "is invalid with too long email" do
    user.email = "a" * 244 + "@example.com"
    expect(user).to_not be_valid
  end

  it "email validation accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      user.email = valid_address
      expect(user).to be_valid, "#{valid_address.inspect} should be valid"
    end
  end

  it "email validation reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      user.email = invalid_address
      expect(user).to_not be_valid, "#{invalid_address.inspect} should be invalid"
    end
  end

  it "email addresses is unique" do
    user.save
    expect(duplicate_user).to_not be_valid
  end

  it "password is present (nonblank)" do
    user.password = user.password_confirmation = " " * 6
    expect(user).to_not be_valid
  end

  it "password have a minimum length" do
    user.password = user.password_confirmation = "a" * 5
    expect(user).to_not be_valid
  end
end
