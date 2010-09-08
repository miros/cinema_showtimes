class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id
      flash[:notice] = "Вы успешно вошли."
      redirect_to_target_or_default(root_url)
    else
      flash.now[:error] = "Неправильный логин или пароль."
      render :action => 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:notice] = "Вы вышли."
    redirect_to root_url
  end
end
