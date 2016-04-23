class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.belongs_to :role
      t.string :user_name
      t.string :account
      t.string :password
      t.string :email
      t.string :auth_token
      t.string :introduce
      t.integer :words_count
      t.timestamps null: false
    end
  end
end
