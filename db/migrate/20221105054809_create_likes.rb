class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.integer :post_id
      t.text :user_id, array: true, default: []

      t.timestamps
    end
  end
end
