# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :forbid_not_logged_in_user, only: %w[index edit update destroy]
  before_action :ensure_correct_user, only: %w[edit update]
  before_action :ensure_admin_user, only: :destroy

  def index
    @users = User.where(activated: true).paginate(page: params[:page], per_page: 25)
  end

  def show
    @user = User.find_by(id: params[:id])
    redirect_to root_url unless @user.activated?
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = <<~TEXT
        ご登録のメールアドレスから、アカウントを有効化して下さい。
      TEXT
      redirect_to root_url
    else
      render action: "new"
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = "プロフィールが更新されました。"
      redirect_to @user
    else
      render "edit"
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "ユーザーを削除しました。"
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :image)
    end

    def forbid_not_logged_in_user
      return if logged_in?

      flash[:danger] = "ログインして下さい。"
      store_location
      redirect_to login_url
    end

    def ensure_correct_user
      @user = User.find_by(id: params[:id])
      redirect_to root_url unless current_user? @user
    end

    def ensure_admin_user
      redirect_to root_url unless current_user.admin?
    end
end
