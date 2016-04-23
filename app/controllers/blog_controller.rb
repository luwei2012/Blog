class BlogController < ApplicationController
  layout 'blog'
  before_filter :check_blog

  def index
    @albums = @user.albums
    @articles = @user.articles
  end


end
