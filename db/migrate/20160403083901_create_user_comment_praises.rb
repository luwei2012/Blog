class CreateUserCommentPraises < ActiveRecord::Migration
  def change
    create_table :user_comment_praises do |t|
      t.belongs_to :user
      t.belongs_to :comment
      t.timestamps null: false
    end
  end
end
