class UserArticleCollection < ActiveRecord::Base
  belongs_to :collected_user, class_name: "User"
  belongs_to :collected_article, class_name: "Article"
end
