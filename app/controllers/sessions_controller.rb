class SessionsController < ApplicationController

  def new
  end

  # Sign in user(helper method located in SessionHelper)
  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      sign_in(@user)
      redirect_to login_path
    else
      flash.now[:danger] = 'Wrong email or password'
      render :new
    end
  end

  # Sign out user(helper method located in SessionHelper)
  def destroy
    sign_out
    redirect_to login_path
  end
end
