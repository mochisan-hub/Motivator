class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.references :user, null: false, foreigh_key: true
      t.references :post, null: false, foreigh_ien: true

      t.timestamps
      t.index [:user_id, :post_id], unique: true
    end
  end
end
