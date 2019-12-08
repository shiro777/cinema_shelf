# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :user_params, only: %w[create update]
  before_action :forbid_not_logged_in_user, only: %w[edit update]
  before_action :ensure_correct_user, only: %w[edit update]

  def index
    # @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # @user.send_activation_email
      log_in @user
      flash[:success] = "新規登録が完了しました。"
      redirect_to @user
    else
      render action: "new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'プロフィールが更新されました。'
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :image)
    end

    def forbid_not_logged_in_user
      unless logged_in?
        flash[:danger] = "ログインして下さい。"
        redirect_to login_url
      end
    end

    def ensure_correct_user
      redirect_to root_url unless params[:id].to_i == current_user.id
    end
end
