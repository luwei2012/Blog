class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.belongs_to :user
      t.belongs_to :article
      t.integer :document_type
      t.integer :status
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
