class CreateUserIcons < ActiveRecord::Migration
  def change
    create_table :user_icons do |t|
      t.belongs_to :user
      t.string :screenshot
      t.string :original
      t.string :title
      t.string :file_name
      t.integer :upload_file_size
      t.string :content
      t.timestamps null: false
    end
  end
end
