class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.string :comment
      t.integer :user_id
      t.integer :post_id
      t.integer :parent_comment_id

      t.timestamps
    end
  end
end
