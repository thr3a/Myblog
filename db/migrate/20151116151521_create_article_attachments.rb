class CreateArticleAttachments < ActiveRecord::Migration
  def change
    create_table :article_attachments do |t|
      t.integer :article_id
      t.string :image

      t.timestamps null: false
    end
  end
end
