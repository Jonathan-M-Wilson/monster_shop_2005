class SessionsController < ApplicationController
  def new
    if current_merchant?
      redirect_to '/merchant'
      flash[:success] = "Logged In"
    elsif current_admin?
      redirect_to '/admin'
      flash[:success] = "Logged In"
    elsif current_user
      redirect_to '/profile'
      flash[:success] = "Logged In"
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password]) && user
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}! You are now logged in."
      redirect_to '/profile'
    else
      flash[:error] = "Sorry, your credentials are bad."
      render :new
    end
  end
end