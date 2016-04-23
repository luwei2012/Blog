class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.belongs_to :album
      t.belongs_to :user
      t.string :title
      t.string :content
      t.integer :words_count
      t.integer :praised_count
      t.integer :collected_count
      t.timestamps null: false
    end
  end
end
