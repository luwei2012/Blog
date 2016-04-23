class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_filter :verify_authenticity_token
  layout false


  def check_login
    flag = false
    set_user_from_cookie
    if @user.blank?
      logger.info 'session timeout OR no cookies in request'
    else
      flag = true
    end
    respond_to do |format|
      if flag
        return true
      else
        format.html { redirect_to :root }
        format.js { render :js => "window.location = '#{root_path}'" }
      end
    end
  end

  def check_blog
    flag = false
    set_user_from_cookie
    if @user.blank?
      logger.info 'session timeout OR no cookies in request'
    else
      session[:user_name] = @user.user_name||@user.email||@user.account
      session[:admin] = (@user.role.authority == ROLE[:admin])
      session[:introduce] = @user.introduce
      session[:words_count] = @user.words_count
      if session[:admin] == 1
        logger.info 'not writer'
      else
        flag = true
      end
    end
    respond_to do |format|
      if flag
        return true
      else
        format.html { redirect_to :root }
        format.js { render :js => "window.location = '#{root_path}'" }
      end
    end
  end

  def check_admin
    flag = false
    set_user_from_cookie
    if @user.blank?
      logger.info 'session timeout OR no cookies in request'
    else
      session[:user_name] = @user.user_name||@user.email||@user.account
      session[:admin] = (@user.role.authority == ROLE[:admin])
      session[:introduce] = @user.introduce
      session[:words_count] = @user.words_count

      if session[:admin] == 0
        logger.info 'not admin'
      else
        flag = true
      end
    end
    respond_to do |format|
      if flag
        return true
      else
        format.html { redirect_to :root }
        format.js { render :js => "window.location = '#{root_path}'" }
      end
    end
  end

  private
  def set_user_from_cookie
    @user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end


end
