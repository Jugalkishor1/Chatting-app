class CreateTable < ActiveRecord::Migration[6.1]
  def change
    create_table "friendships", force: :cascade do |t|
      t.belongs_to :user
      t.integer :friend_id
      t.boolean :status
    end
  add_foreign_key "friendships", "users"
  add_foreign_key "friendships", "users", column: "friend_id"
  end
end