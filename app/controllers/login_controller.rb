class LoginController < ApplicationController
  layout 'login'
  before_action :set_user_from_cookie , only: [:modify, :modify_update, :index]

  def index
    if not @user.blank?
      session[:user_name] = @user.user_name||@user.email||@user.account
      session[:admin] = (@user.role.authority == ROLE[:admin])
      session[:introduce] = @user.introduce
      session[:words_count] = @user.words_count

      if session[:admin] == 1
        # 管理员进入写手管理页面
        redirect_to :controller => :admin, :action => :index and return
      else
        # 写手进入自己博客主页
        redirect_to :controller => :blog, :action => :index and return
      end
    else
      render :action => :index
    end
  end

  def logout
    session.clear
    cookies.delete(:auth_token)
    redirect_to root_url, :notice => "Logged out!"
  end

  def login
    account = params[:account]
    password = params[:password]
    if !(account.blank? || password.blank?)
      user = User.find_by_account(account)
      if user && user.authenticate(password)
        #render to shop
        if params[:remember]
          cookies.permanent[:auth_token] = {
              value: user.auth_token,
              expires: (Time.now.midnight + 7.days)
          }
        else
          cookies[:auth_token] = {
              value: user.auth_token,
              expires: (Time.now.midnight + 7.days)
          }
        end
        session[:user_name] = user.user_name||user.email||user.account
        session[:admin] = (user.role.authority == ROLE[:admin])
        session[:introduce] = user.introduce
        session[:words_count] = user.words_count
        if session[:admin] == 1
          # 管理员进入写手管理页面
          redirect_to :controller => :admin, :action => :index and return
        else
          # 写手进入自己博客主页
          redirect_to :controller => :blog, :action => :index and return
        end

      else
        flash.now[:error] = '账号或密码不正确！'
      end
    end

    render :action => :index
  end

  def reset
    user = User.find_by_email(params[:email])
    user.send_password_reset(request) if user
    redirect_to root_url, :notice => "Email sent with password reset instructions."
  end

  def password_modify
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def modify
  end

  def modify_update
    @user.password = params[:password]
    begin
      User.transaction do
        @user.save!
      end
    rescue
      error_message = ''
      @user.errors[:error_message].each do |error|
        if error == @user.errors[:error_message].last
          error_message += error.to_s
        else
          error_message += error.to_s + ','
        end
      end
      flash.now[:error] = error_message
      render action: :modify and return
    end
    redirect_to root_url, :notice => "Password has been reset."
  end


  def update_password
    @user = User.find_by_password_reset_token!(params[:id])
    if !@user.blank? && @user.password_reset_sent_at < 2.hours.ago
      redirect_to root_url, :alert => "Password reset has expired."
    else
      @user.password = params[:password]
      @user.password_reset_token = nil
      begin
        User.transaction do
          @user.save!
        end
        redirect_to root_url, :notice => "Password has been reset."
      rescue
        error_message = ''
        @user.errors[:error_message].each do |error|
          if error == @user.errors[:error_message].last
            error_message += error.to_s
          else
            error_message += error.to_s + ','
          end
        end
        flash.now[:error] = error_message
        render :password_modify
      end
    end
  end

end
