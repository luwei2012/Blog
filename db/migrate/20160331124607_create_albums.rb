class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.belongs_to :user
      t.string :album_name
      t.integer :words_count
      t.timestamps null: false
    end
  end
end
