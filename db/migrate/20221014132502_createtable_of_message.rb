class CreatetableOfMessage < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.string :m_body
      t.integer :sender_id
      t.integer :group_id

      t.timestamps
    end
  end
end
