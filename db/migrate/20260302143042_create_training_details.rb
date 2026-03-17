class CreateTrainingDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :training_details do |t|
      t.references :post, null: false, foreign_key: true
      t.integer :body_part
      t.string :menu
      t.integer :reps
      t.float :weight
      t.float :distance
      t.integer :time

      t.timestamps
    end
  end
end
