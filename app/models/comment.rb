class Comment < ActiveRecord::Base

  belongs_to :user

  has_many :sub_comment, class_name: "Comment",
           foreign_key: "parent_comment_id",
           dependent: :destroy

  has_many :user_comment_praises
  has_many :praised_users, class_name: "User", :through => :user_comment_praises

  belongs_to :parent_comment, class_name: "Comment"
  belongs_to :article

  validates :content, length: {minimum: 5}

end
