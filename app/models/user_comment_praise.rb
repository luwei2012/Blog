class UserCommentPraise < ActiveRecord::Base
  belongs_to :praised_user, class_name: "User"
  belongs_to :praised_comment, class_name: "Comment"
end
