class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.integer :member, array: true, default: []
      t.integer :created_by

      t.timestamps
    end
  end
end
