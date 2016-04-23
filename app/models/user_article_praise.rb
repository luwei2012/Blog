class UserArticlePraise < ActiveRecord::Base
  belongs_to :praised_user, class_name: "User"
  belongs_to :praised_article, class_name: "Article"
end
