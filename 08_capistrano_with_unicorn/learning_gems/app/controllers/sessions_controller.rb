class SessionsController < ApplicationController
  
  before_action :auth_user, except: [:destroy]

  def new
  end

  def create
    if user = login(params[:email], params[:password])
      flash[:notice] = '登陆成功'
      redirect_to root_path
    else
      flash[:notice] = "邮箱或者密码错误"
      redirect_to new_session_path
    end
  end

  def destroy
    logout
    flash[:notice] = "退出登陆"
    redirect_to root_path
  end

  private
  def auth_user
    if logged_in?
      redirect_to root_path
    end
  end

end
