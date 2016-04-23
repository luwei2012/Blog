class CreateUserArticlePraises < ActiveRecord::Migration
  def change
    create_table :user_article_praises do |t|
      t.belongs_to :user
      t.belongs_to :article
      t.timestamps null: false
    end
  end
end
