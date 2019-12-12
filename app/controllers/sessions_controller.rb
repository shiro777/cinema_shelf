# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user&.authenticate(params[:session][:password])
      if @user.activated?
        log_in @user
        remember @user if params[:session][:remember_me] == "1"
        redirect_back_or @user
      else
        flash[:warning] = <<~TEXT
          アカウントが有効になっていません。
          ご登録メールアドレスに送信されたメールから、アカウントを有効化してください。
        TEXT
        redirect_to root_url
      end
    else
      flash.now[:danger] = "メールアドレスかパスワードが間違っています。"
      render "new"
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
