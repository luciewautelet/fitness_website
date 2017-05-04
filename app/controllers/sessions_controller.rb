class SessionsController < ApplicationController

  def new
  end

  def create
    admin = Admin.find_by(name: params[:session][:name])
    if admin && admin.authenticate(params[:session][:password])
      log_in admin
      redirect_back_or root_path
    else
      flash.now[:error] = "Invalid name/password combination"
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end