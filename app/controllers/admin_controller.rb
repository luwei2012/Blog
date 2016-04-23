class AdminController < ApplicationController
  layout 'admin'
  before_filter :check_admin

  def index
    @albums = @user.albums
    @articles = @user.articles
  end


end
