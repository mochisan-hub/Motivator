class CreatePostComments < ActiveRecord::Migration[6.1]
  def change
    create_table :post_comments do |t|
      t.text :comment, null: false
      t.references :user, null: false, foreigh_key: true
      t.references :post, null: false, foreigh_ien: true

      t.timestamps
    end
  end
end
