class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user)
      .permit(:email, :password, :password_confirmation))
    
    if @user.save
      flash[:notice] = '注册成功，请登录'
      redirect_to new_session_path
    else
      render action: :new
    end
  end

  def change_password
    if current_user.valid_password?(params[:old_password])
      current_user.password_confirmation = params[:password_confirmation]
      
      if current_user.change_password!(params[:password])
        render json: {status: 'ok', msg: '密码修改成功'}
      else
        render json: {status: 'error', msg: current_user.errors.messages.values.flatten}
      end
    else
      render json: {status: 'error', msg: '旧密码不正确'}
    end
  end

  def send_forget_password_email
    @user = User.find_by(email: params[:email])
    if @user
      @user.deliver_reset_password_instructions!
      render json: {status: 'ok', msg: "重置密码的链接已发送到上面的邮箱"}
    else
      render json: {status: 'error', msg: '指定邮箱不存在'}
    end
  end

  def reset_password
    @user = User.load_from_reset_password_token(params[:token])
    if @user
      @user.password_confirmation = params[:password_confirmation]
      if @user.change_password!(params[:password])
        render json: {status: 'ok', msg: '密码修改成功'}
      else
        render json: {status: 'error', msg: @user.errors.messages.values.flatten}
      end
    else
      render json: {status: 'error', msg: 'token不正确或者已过期'}
    end
  end

end
