# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :user_params, only: %w[create update]

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
    # if @user.update_attributes(params[:user])
    #   flash[:success] = 'Profile updated'
    #   sign_in @user
    #   redirect_to @user
    # else
    #   render 'edit'
    # end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :image)
    end
end
